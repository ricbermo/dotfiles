#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)

run_capture() {
  local output
  local status

  set +e
  output=$("$@" 2>&1)
  status=$?
  set -e

  CAPTURED_OUTPUT=$output
  CAPTURED_STATUS=$status
}

assert_file_equals() {
  local path=$1
  local expected=$2
  local actual

  if [ ! -f "$path" ]; then
    printf 'Expected file to exist: %s\n' "$path"
    exit 1
  fi

  actual=$(<"$path")
  if [ "$actual" != "$expected" ]; then
    printf 'Unexpected file content for %s\n' "$path"
    printf 'Expected:\n%s\n' "$expected"
    printf 'Actual:\n%s\n' "$actual"
    exit 1
  fi
}

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

MOCK_BIN_DIR="$WORK_DIR/mock-bin"
OUT_DIR="$WORK_DIR/audit-out"
mkdir -p "$MOCK_BIN_DIR"

cat >"$MOCK_BIN_DIR/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

case "$*" in
  leaves)
    printf 'ripgrep\n'
    printf 'fzf\n'
    printf 'asdf\n'
    printf 'fzf\n'
    printf 'ripgrep\n'
    ;;
  'list --cask')
    printf 'nikitabobko/tap/aerospace\n'
    printf 'font-hack-nerd-font\n'
    printf 'nikitabobko/tap/aerospace\n'
    ;;
  tap)
    printf 'FelixKratz/formulae\n'
    printf 'homebrew/core\n'
    printf 'FelixKratz/formulae\n'
    ;;
  *)
    printf 'Unexpected brew invocation: %s\n' "$*" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$MOCK_BIN_DIR/brew"

run_capture env PATH="$MOCK_BIN_DIR:$PATH" AUDIT_OUT_DIR="$OUT_DIR" /bin/bash "$ROOT_DIR/scripts/audit-brew.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected audit-brew script to succeed, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi

assert_file_equals "$OUT_DIR/formulae.txt" $'asdf\nfzf\nripgrep'
assert_file_equals "$OUT_DIR/casks.txt" $'font-hack-nerd-font\nnikitabobko/tap/aerospace'
assert_file_equals "$OUT_DIR/taps.txt" $'FelixKratz/formulae\nhomebrew/core'

case "$CAPTURED_OUTPUT" in
  *"Audit complete. Files written to: $OUT_DIR"*) ;;
  *)
    printf 'Expected completion message with output dir.\nOutput:\n%s\n' "$CAPTURED_OUTPUT"
    exit 1
    ;;
esac

EMPTY_BIN_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR" "$EMPTY_BIN_DIR" "${FAIL_WORK_DIR:-}"' EXIT

run_capture env PATH="$EMPTY_BIN_DIR" /bin/bash "$ROOT_DIR/scripts/audit-brew.sh"
if [ "$CAPTURED_STATUS" -eq 0 ]; then
  printf 'Expected audit-brew to fail when brew is missing\n%s\n' "$CAPTURED_OUTPUT"
  exit 1
fi

case "$CAPTURED_OUTPUT" in
  *'ERROR: required command not found: brew'*) ;;
  *)
    printf 'Expected missing-brew error output.\nOutput:\n%s\n' "$CAPTURED_OUTPUT"
    exit 1
    ;;
esac

FAIL_WORK_DIR=$(mktemp -d)
FAIL_BIN_DIR="$FAIL_WORK_DIR/mock-bin"
FAIL_OUT_DIR="$FAIL_WORK_DIR/audit-out"
mkdir -p "$FAIL_BIN_DIR"

cat >"$FAIL_BIN_DIR/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

case "$*" in
  leaves)
    printf 'asdf\n'
    ;;
  'list --cask')
    printf 'simulated brew list cask failure\n' >&2
    exit 3
    ;;
  tap)
    printf 'homebrew/core\n'
    ;;
  *)
    printf 'Unexpected brew invocation: %s\n' "$*" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$FAIL_BIN_DIR/brew"

run_capture env PATH="$FAIL_BIN_DIR:$PATH" AUDIT_OUT_DIR="$FAIL_OUT_DIR" /bin/bash "$ROOT_DIR/scripts/audit-brew.sh"
if [ "$CAPTURED_STATUS" -eq 0 ]; then
  printf 'Expected audit-brew to fail on brew command error\n%s\n' "$CAPTURED_OUTPUT"
  exit 1
fi

if [ "$CAPTURED_STATUS" -ne 3 ]; then
  printf 'Expected audit-brew to exit with failing subcommand status 3, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi

case "$CAPTURED_OUTPUT" in
  *'simulated brew list cask failure'*) ;;
  *)
    printf 'Expected failing-brew stderr in output.\nOutput:\n%s\n' "$CAPTURED_OUTPUT"
    exit 1
    ;;
esac

printf 'PASS: audit brew writes expected output files\n'
