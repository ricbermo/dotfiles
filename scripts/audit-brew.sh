#!/usr/bin/env bash

set -euo pipefail

OUT_DIR=${AUDIT_OUT_DIR:-.audit/brew}

require_command() {
  local tool=$1

  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'ERROR: required command not found: %s\n' "$tool" >&2
    exit 1
  fi
}

require_command brew

mkdir -p "$OUT_DIR"

brew leaves | LC_ALL=C sort -u >"$OUT_DIR/formulae.txt"
brew list --cask | LC_ALL=C sort -u >"$OUT_DIR/casks.txt"
brew tap | LC_ALL=C sort -u >"$OUT_DIR/taps.txt"

ABS_OUT_DIR=$(CDPATH= cd -- "$OUT_DIR" && pwd)
printf 'Audit complete. Files written to: %s\n' "$ABS_OUT_DIR"
