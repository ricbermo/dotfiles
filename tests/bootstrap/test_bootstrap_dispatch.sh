#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)

run_capture() {
  set +e
  CAPTURED_OUTPUT=$("$@" 2>&1)
  CAPTURED_STATUS=$?
  set -e
}

FIXTURE_DIR=

cleanup_fixture() {
  if [ -n "$FIXTURE_DIR" ] && [ -d "$FIXTURE_DIR" ]; then
    rm -rf "$FIXTURE_DIR"
  fi
}

trap cleanup_fixture EXIT INT TERM

make_fixture() {
  cleanup_fixture
  FIXTURE_DIR=$(mktemp -d)
  mkdir -p "$FIXTURE_DIR/scripts"

  cp "$ROOT_DIR/bootstrap.sh" "$FIXTURE_DIR/bootstrap.sh"
  chmod +x "$FIXTURE_DIR/bootstrap.sh"

  cp "$ROOT_DIR/scripts/setup-brew.sh" "$FIXTURE_DIR/scripts/setup-brew.sh"
  cp "$ROOT_DIR/scripts/setup-dotfiles.sh" "$FIXTURE_DIR/scripts/setup-dotfiles.sh"
  cp "$ROOT_DIR/scripts/post-setup.sh" "$FIXTURE_DIR/scripts/post-setup.sh"
  chmod +x "$FIXTURE_DIR/scripts/setup-brew.sh"
  chmod +x "$FIXTURE_DIR/scripts/setup-dotfiles.sh"
  chmod +x "$FIXTURE_DIR/scripts/post-setup.sh"
}

assert_contains() {
  text=$1
  expected=$2

  case "$text" in
    *"$expected"*) ;;
    *)
      echo "Expected output to contain: $expected"
      echo "Actual output:"
      echo "$text"
      exit 1
      ;;
  esac
}

assert_equals() {
  actual=$1
  expected=$2

  if [ "$actual" != "$expected" ]; then
    echo "Expected exact output:"
    echo "$expected"
    echo "Actual output:"
    echo "$actual"
    exit 1
  fi
}

run_capture env DRY_RUN=1 "$ROOT_DIR/bootstrap.sh" --brew

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected --brew to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_equals "$CAPTURED_OUTPUT" "brew bundle --file Brewfile"

run_capture env DRY_RUN=1 "$ROOT_DIR/bootstrap.sh" --dotfiles

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected --dotfiles to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_equals "$CAPTURED_OUTPUT" 'stow --target "$HOME" --dir stow zsh tmux git aerospace sketchybar bat tmuxai'

run_capture env DRY_RUN=1 "$ROOT_DIR/bootstrap.sh" --post

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected --post to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_equals "$CAPTURED_OUTPUT" "post-setup placeholder: configure remaining manual steps"

run_capture env DRY_RUN=1 "$ROOT_DIR/bootstrap.sh" --all

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected --all to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

EXPECTED_ALL=$(printf '%s\n%s\n%s' \
  "brew bundle --file Brewfile" \
  'stow --target "$HOME" --dir stow zsh tmux git aerospace sketchybar bat tmuxai' \
  "post-setup placeholder: configure remaining manual steps")
assert_equals "$CAPTURED_OUTPUT" "$EXPECTED_ALL"

make_fixture
rm -f "$FIXTURE_DIR/scripts/post-setup.sh"

run_capture env DRY_RUN=1 "$FIXTURE_DIR/bootstrap.sh" --post

if [ "$CAPTURED_STATUS" -eq 0 ]; then
  echo "Expected --post to fail when script is missing"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_contains "$CAPTURED_OUTPUT" "ERROR: target script missing or not executable"
assert_contains "$CAPTURED_OUTPUT" "$FIXTURE_DIR/scripts/post-setup.sh"

make_fixture
chmod -x "$FIXTURE_DIR/scripts/post-setup.sh"

run_capture env DRY_RUN=1 "$FIXTURE_DIR/bootstrap.sh" --post

if [ "$CAPTURED_STATUS" -eq 0 ]; then
  echo "Expected --post to fail when script is not executable"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_contains "$CAPTURED_OUTPUT" "ERROR: target script missing or not executable"
assert_contains "$CAPTURED_OUTPUT" "$FIXTURE_DIR/scripts/post-setup.sh"

run_capture env DRY_RUN=1 "$ROOT_DIR/bootstrap.sh" --brew unexpected

if [ "$CAPTURED_STATUS" -eq 0 ]; then
  echo "Expected extra positional arg to exit non-zero"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_contains "$CAPTURED_OUTPUT" "ERROR: unexpected positional arguments"
assert_contains "$CAPTURED_OUTPUT" "unexpected"

run_capture "$ROOT_DIR/bootstrap.sh" --unknown

if [ "$CAPTURED_STATUS" -eq 0 ]; then
  echo "Expected unknown flag to exit non-zero"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_contains "$CAPTURED_OUTPUT" "--brew"
assert_contains "$CAPTURED_OUTPUT" "--dotfiles"
assert_contains "$CAPTURED_OUTPUT" "--post"
assert_contains "$CAPTURED_OUTPUT" "--all"

echo "PASS: bootstrap dispatch and unknown flag contract"
