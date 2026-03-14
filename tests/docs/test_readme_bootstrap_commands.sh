#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
README_PATH="$ROOT_DIR/README.md"

assert_contains() {
  text=$1
  expected=$2

  case "$text" in
    *"$expected"*) ;;
    *)
      echo "Expected README to contain: $expected"
      exit 1
      ;;
  esac
}

README_CONTENT=$(cat "$README_PATH")

assert_contains "$README_CONTENT" "./bootstrap.sh --brew"
assert_contains "$README_CONTENT" "./bootstrap.sh --dotfiles"
assert_contains "$README_CONTENT" "./bootstrap.sh --post"
assert_contains "$README_CONTENT" "./bootstrap.sh --all"
assert_contains "$README_CONTENT" "scripts/audit-brew.sh"
assert_contains "$README_CONTENT" "install.sh"
assert_contains "$README_CONTENT" "deprecated"

echo "PASS: README documents phased bootstrap flow"
