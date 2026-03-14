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

assert_contains() {
  local text=$1
  local expected=$2

  case "$text" in
    *"$expected"*) ;;
    *)
      printf 'Expected output to contain:\n%s\n' "$expected"
      printf 'Actual output:\n%s\n' "$text"
      exit 1
      ;;
  esac
}

assert_equals() {
  local actual=$1
  local expected=$2

  if [ "$actual" != "$expected" ]; then
    printf 'Expected: %s\n' "$expected"
    printf 'Actual: %s\n' "$actual"
    exit 1
  fi
}

assert_non_zero() {
  local status=$1

  if [ "$status" -eq 0 ]; then
    printf 'Expected non-zero exit status, got 0\n'
    exit 1
  fi
}

ensure_brewfile_exists() {
  if [ -f "$ROOT_DIR/Brewfile" ]; then
    CREATED_BREWFILE=0
    return
  fi

  CREATED_BREWFILE=1
  cat >"$ROOT_DIR/Brewfile" <<'EOF'
tap "homebrew/core"
EOF
}

cleanup_brewfile() {
  if [ "${CREATED_BREWFILE:-0}" = "1" ]; then
    rm -f "$ROOT_DIR/Brewfile"
  fi
}

ensure_brewfile_exists
trap cleanup_brewfile EXIT

run_capture env DRY_RUN=1 /bin/bash "$ROOT_DIR/scripts/verify-bootstrap.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected verify-bootstrap script to exit 0, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi

assert_contains "$CAPTURED_OUTPUT" 'brew bundle check:'
assert_contains "$CAPTURED_OUTPUT" 'stow symlink check:'
assert_contains "$CAPTURED_OUTPUT" 'tool check (tmux):'
assert_contains "$CAPTURED_OUTPUT" 'tool check (nvim):'
assert_contains "$CAPTURED_OUTPUT" 'tool check (sketchybar):'
assert_contains "$CAPTURED_OUTPUT" 'verification summary: PASS'

run_capture env PATH='/usr/bin:/bin' /bin/bash "$ROOT_DIR/scripts/verify-bootstrap.sh"
assert_non_zero "$CAPTURED_STATUS"
assert_contains "$CAPTURED_OUTPUT" 'brew bundle check: FAIL - brew not found'
assert_contains "$CAPTURED_OUTPUT" 'stow symlink check: FAIL - stow not found'
assert_contains "$CAPTURED_OUTPUT" 'verification summary: FAIL'

BREW_FAIL_WORK_DIR=$(mktemp -d)
STOW_FAIL_WORK_DIR=$(mktemp -d)
PASS_WORK_DIR=$(mktemp -d)
trap 'cleanup_brewfile; rm -rf "$BREW_FAIL_WORK_DIR" "$STOW_FAIL_WORK_DIR" "$PASS_WORK_DIR"' EXIT

BREW_FAIL_BIN_DIR="$BREW_FAIL_WORK_DIR/mock-bin"
mkdir -p "$BREW_FAIL_BIN_DIR"

cat >"$BREW_FAIL_BIN_DIR/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [ "$*" = 'bundle check --file Brewfile' ]; then
  printf 'brew check stdout context\n'
  printf 'brew check stderr failure\n' >&2
  exit 1
fi

printf 'Unexpected brew invocation: %s\n' "$*" >&2
exit 1
EOF
chmod +x "$BREW_FAIL_BIN_DIR/brew"

run_capture env PATH="$BREW_FAIL_BIN_DIR:$PATH" /bin/bash "$ROOT_DIR/scripts/verify-bootstrap.sh"
assert_non_zero "$CAPTURED_STATUS"
assert_contains "$CAPTURED_OUTPUT" 'brew bundle check: FAIL'
assert_contains "$CAPTURED_OUTPUT" 'brew check stderr failure'
assert_contains "$CAPTURED_OUTPUT" 'verification summary: FAIL'

STOW_FAIL_BIN_DIR="$STOW_FAIL_WORK_DIR/mock-bin"
mkdir -p "$STOW_FAIL_BIN_DIR"

cat >"$STOW_FAIL_BIN_DIR/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [ "$*" = 'bundle check --file Brewfile' ]; then
  exit 0
fi

printf 'Unexpected brew invocation: %s\n' "$*" >&2
exit 1
EOF

cat >"$STOW_FAIL_BIN_DIR/stow" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

printf 'stow simulate failure details\n' >&2
exit 2
EOF

chmod +x "$STOW_FAIL_BIN_DIR/brew" "$STOW_FAIL_BIN_DIR/stow"

run_capture env PATH="$STOW_FAIL_BIN_DIR:$PATH" /bin/bash "$ROOT_DIR/scripts/verify-bootstrap.sh"
assert_non_zero "$CAPTURED_STATUS"
assert_contains "$CAPTURED_OUTPUT" 'stow symlink check: FAIL'
assert_contains "$CAPTURED_OUTPUT" 'stow simulate failure details'
assert_contains "$CAPTURED_OUTPUT" 'verification summary: FAIL'

PASS_BIN_DIR="$PASS_WORK_DIR/mock-bin"
mkdir -p "$PASS_BIN_DIR"

cat >"$PASS_BIN_DIR/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [ "$*" = 'bundle check --file Brewfile' ]; then
  if [ "${HOMEBREW_NO_AUTO_UPDATE:-}" != '1' ]; then
    printf 'HOMEBREW_NO_AUTO_UPDATE must be 1\n' >&2
    exit 9
  fi
  exit 0
fi

printf 'Unexpected brew invocation: %s\n' "$*" >&2
exit 1
EOF

cat >"$PASS_BIN_DIR/stow" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [ "$1" = '--simulate' ]; then
  exit 0
fi

printf 'Expected --simulate invocation\n' >&2
exit 1
EOF

for tool in tmux nvim sketchybar; do
  cat >"$PASS_BIN_DIR/$tool" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
exit 0
EOF
  chmod +x "$PASS_BIN_DIR/$tool"
done

chmod +x "$PASS_BIN_DIR/brew" "$PASS_BIN_DIR/stow"

run_capture env PATH="$PASS_BIN_DIR:/usr/bin:/bin" /bin/bash "$ROOT_DIR/scripts/verify-bootstrap.sh"
assert_equals "$CAPTURED_STATUS" '0'
assert_contains "$CAPTURED_OUTPUT" 'verification summary: PASS'

printf 'PASS: verify bootstrap output contract\n'
