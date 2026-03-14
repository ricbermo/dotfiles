#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

require_command() {
  local tool=$1

  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'ERROR: required command not found: %s\n' "$tool" >&2
    exit 1
  fi
}

BREW_COMMAND=(brew bundle --file Brewfile)

if [ "${DRY_RUN:-0}" = "1" ]; then
  printf '%s\n' "${BREW_COMMAND[*]}"
  exit 0
fi

require_command brew
cd "$ROOT_DIR"
"${BREW_COMMAND[@]}"
