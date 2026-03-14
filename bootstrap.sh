#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [--brew|--dotfiles|--post|--all|--help]

Options:
  --brew      bootstrap brew dependencies
  --dotfiles  bootstrap dotfiles links
  --post      run post-bootstrap steps
  --all       run all bootstrap steps
  --help      show this help message
EOF
}

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

run_phase_script() {
  script_path=$1

  if [ ! -x "$script_path" ]; then
    printf 'ERROR: target script missing or not executable: %s\n' "$script_path" >&2
    exit 1
  fi

  "$script_path"
}

if [ "$#" -eq 0 ]; then
  usage
  exit 0
fi

if [ "$#" -gt 1 ]; then
  printf 'ERROR: unexpected positional arguments: %s\n' "${*:2}" >&2
  usage
  exit 1
fi

case "$1" in
  --help|-h)
    usage
    ;;
  --brew)
    run_phase_script "$SCRIPT_DIR/scripts/setup-brew.sh"
    ;;
  --dotfiles)
    run_phase_script "$SCRIPT_DIR/scripts/setup-dotfiles.sh"
    ;;
  --post)
    run_phase_script "$SCRIPT_DIR/scripts/post-setup.sh"
    ;;
  --all)
    run_phase_script "$SCRIPT_DIR/scripts/setup-brew.sh"
    run_phase_script "$SCRIPT_DIR/scripts/setup-dotfiles.sh"
    run_phase_script "$SCRIPT_DIR/scripts/post-setup.sh"
    ;;
  *)
    usage
    exit 1
    ;;
esac
