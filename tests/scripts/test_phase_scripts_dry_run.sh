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

assert_equals() {
  local actual=$1
  local expected=$2

  if [ "$actual" != "$expected" ]; then
    printf 'Expected exact output:\n%s\n' "$expected"
    printf 'Actual output:\n%s\n' "$actual"
    exit 1
  fi
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

assert_non_empty() {
  local text=$1

  if [ -z "$text" ]; then
    printf 'Expected non-empty output, got empty\n'
    exit 1
  fi
}

run_capture env DRY_RUN=1 "$ROOT_DIR/scripts/setup-brew.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected setup-brew dry-run to exit 0, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi
assert_equals "$CAPTURED_OUTPUT" 'brew bundle --file Brewfile'

run_capture env DRY_RUN=1 "$ROOT_DIR/scripts/setup-dotfiles.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected setup-dotfiles dry-run to exit 0, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi
assert_equals "$CAPTURED_OUTPUT" 'stow --target "$HOME" --dir stow zsh tmux git aerospace sketchybar bat tmuxai'

run_capture env DRY_RUN=1 "$ROOT_DIR/scripts/post-setup.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected post-setup dry-run to exit 0, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi
assert_non_empty "$CAPTURED_OUTPUT"
assert_equals "$CAPTURED_OUTPUT" 'post-setup placeholder: configure remaining manual steps'

run_capture "$ROOT_DIR/scripts/post-setup.sh"
if [ "$CAPTURED_STATUS" -ne 0 ]; then
  printf 'Expected post-setup non-dry mode to exit 0, got %s\n%s\n' "$CAPTURED_STATUS" "$CAPTURED_OUTPUT"
  exit 1
fi
assert_equals "$CAPTURED_OUTPUT" 'NOTICE: no automated post-setup actions were run; manual post-setup steps are still required.'

EMPTY_BIN_DIR=$(mktemp -d)
trap 'rm -rf "$EMPTY_BIN_DIR"' EXIT

run_capture env PATH="$EMPTY_BIN_DIR" /bin/bash "$ROOT_DIR/scripts/setup-brew.sh"
if [ "$CAPTURED_STATUS" -eq 0 ]; then
  printf 'Expected setup-brew to fail when brew is missing\n%s\n' "$CAPTURED_OUTPUT"
  exit 1
fi
assert_contains "$CAPTURED_OUTPUT" 'ERROR: required command not found: brew'

run_capture env PATH="$EMPTY_BIN_DIR" /bin/bash "$ROOT_DIR/scripts/setup-dotfiles.sh"
if [ "$CAPTURED_STATUS" -eq 0 ]; then
  printf 'Expected setup-dotfiles to fail when stow is missing\n%s\n' "$CAPTURED_OUTPUT"
  exit 1
fi
assert_contains "$CAPTURED_OUTPUT" 'ERROR: required command not found: stow'

printf 'PASS: phase scripts dry-run contract\n'
