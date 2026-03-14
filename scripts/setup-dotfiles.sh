#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
PACKAGES_FILE="$SCRIPT_DIR/stow-packages.txt"

require_command() {
  local tool=$1

  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'ERROR: required command not found: %s\n' "$tool" >&2
    exit 1
  fi
}

STOW_FLAGS=(--dir stow)

load_stow_packages() {
  local file_path=$1
  local line

  if [ ! -f "$file_path" ]; then
    printf 'ERROR: stow package list not found: %s\n' "$file_path" >&2
    exit 1
  fi

  STOW_PACKAGES=()
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*) continue ;;
    esac
    STOW_PACKAGES+=("$line")
  done < "$file_path"

  if [ "${#STOW_PACKAGES[@]}" -eq 0 ]; then
    printf 'ERROR: stow package list is empty: %s\n' "$file_path" >&2
    exit 1
  fi
}

print_stow_command() {
  printf 'stow --target "$HOME"'

  local arg
  for arg in "${STOW_FLAGS[@]}" "${STOW_PACKAGES[@]}"; do
    printf ' %s' "$arg"
  done

  printf '\n'
}

run_stow_command() {
  stow --target "$HOME" "${STOW_FLAGS[@]}" "${STOW_PACKAGES[@]}"
}

if [ "${DRY_RUN:-0}" = "1" ]; then
  load_stow_packages "$PACKAGES_FILE"
  print_stow_command
  exit 0
fi

require_command stow
load_stow_packages "$PACKAGES_FILE"
cd "$ROOT_DIR"
run_stow_command
