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

assert_usage_contract() {
  text=$1
  assert_contains "$text" "--brew"
  assert_contains "$text" "--dotfiles"
  assert_contains "$text" "--post"
  assert_contains "$text" "--all"
}

run_capture "$ROOT_DIR/bootstrap.sh" --help

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected --help to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_usage_contract "$CAPTURED_OUTPUT"

run_capture "$ROOT_DIR/bootstrap.sh"

if [ "$CAPTURED_STATUS" -ne 0 ]; then
  echo "Expected no-args to exit 0, got $CAPTURED_STATUS"
  echo "$CAPTURED_OUTPUT"
  exit 1
fi

assert_usage_contract "$CAPTURED_OUTPUT"

echo "PASS: bootstrap usage help and no-args contract"
