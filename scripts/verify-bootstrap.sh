#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
PACKAGES_FILE="$SCRIPT_DIR/stow-packages.txt"

FAILURES=0

print_check() {
  local label=$1
  local status=$2
  local detail=$3

  printf '%s: %s - %s\n' "$label" "$status" "$detail"
}

mark_failure() {
  FAILURES=$((FAILURES + 1))
}

capture_command_output() {
  local output_var=$1
  local status_var=$2
  shift 2

  local output
  local status

  set +e
  output=$("$@" 2>&1)
  status=$?
  set -e

  printf -v "$output_var" '%s' "$output"
  printf -v "$status_var" '%s' "$status"
}

output_snippet() {
  local output=$1
  local max_lines=8
  local line_count=0
  local line
  local snippet=''

  while IFS= read -r line; do
    line_count=$((line_count + 1))
    if [ "$line_count" -le "$max_lines" ]; then
      if [ -n "$snippet" ]; then
        snippet+=$'\n'
      fi
      snippet+="$line"
    fi
  done <<< "$output"

  if [ "$line_count" -gt "$max_lines" ]; then
    snippet+=$'\n...'
  fi

  printf '%s' "$snippet"
}

run_in_root() {
  (cd "$ROOT_DIR" && "$@")
}

load_stow_packages() {
  local file_path=$1
  local line

  STOW_PACKAGES=()
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*) continue ;;
    esac
    STOW_PACKAGES+=("$line")
  done < "$file_path"
}

verify_brew_bundle() {
  local label='brew bundle check'

  if [ "${DRY_RUN:-0}" = "1" ]; then
    print_check "$label" 'DRY-RUN' 'would run: brew bundle check --file Brewfile'
    return
  fi

  if ! command -v brew >/dev/null 2>&1; then
    print_check "$label" 'FAIL' 'brew not found'
    mark_failure
    return
  fi

  if [ ! -f "$ROOT_DIR/Brewfile" ]; then
    print_check "$label" 'FAIL' 'Brewfile not found'
    mark_failure
    return
  fi

  local command_output
  local command_status
  local detail

  capture_command_output command_output command_status run_in_root env HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --file Brewfile
  if [ "$command_status" -eq 0 ]; then
    print_check "$label" 'PASS' 'brew bundle check succeeded'
  else
    detail=$(output_snippet "$command_output")
    if [ -n "$detail" ]; then
      print_check "$label" 'FAIL' "$detail"
    else
      print_check "$label" 'FAIL' 'brew bundle check failed (no diagnostic output)'
    fi
    mark_failure
  fi
}

verify_stow_symlinks() {
  local label='stow symlink check'

  if [ "${DRY_RUN:-0}" = "1" ]; then
    print_check "$label" 'DRY-RUN' 'would run: stow --simulate --target "$HOME" --dir stow <packages>'
    return
  fi

  if ! command -v stow >/dev/null 2>&1; then
    print_check "$label" 'FAIL' 'stow not found'
    mark_failure
    return
  fi

  if [ ! -f "$PACKAGES_FILE" ]; then
    print_check "$label" 'FAIL' 'stow package list not found'
    mark_failure
    return
  fi

  load_stow_packages "$PACKAGES_FILE"
  if [ "${#STOW_PACKAGES[@]}" -eq 0 ]; then
    print_check "$label" 'FAIL' 'stow package list is empty'
    mark_failure
    return
  fi

  local command_output
  local command_status
  local detail

  capture_command_output command_output command_status run_in_root stow --simulate --target "$HOME" --dir stow "${STOW_PACKAGES[@]}"
  if [ "$command_status" -eq 0 ]; then
    print_check "$label" 'PASS' 'stow simulate succeeded'
  else
    detail=$(output_snippet "$command_output")
    if [ -n "$detail" ]; then
      print_check "$label" 'FAIL' "$detail"
    else
      print_check "$label" 'FAIL' 'stow simulate failed (no diagnostic output)'
    fi
    mark_failure
  fi
}

verify_tool() {
  local tool=$1
  local label="tool check ($tool)"

  if [ "${DRY_RUN:-0}" = "1" ]; then
    print_check "$label" 'DRY-RUN' "would run: command -v $tool"
    return
  fi

  if command -v "$tool" >/dev/null 2>&1; then
    print_check "$label" 'PASS' 'command is available'
  else
    print_check "$label" 'SKIP' 'command not found'
  fi
}

verify_brew_bundle
verify_stow_symlinks
verify_tool 'tmux'
verify_tool 'nvim'
verify_tool 'sketchybar'

if [ "$FAILURES" -gt 0 ]; then
  printf 'verification summary: FAIL (%s failed checks)\n' "$FAILURES"
  exit 1
fi

printf 'verification summary: PASS\n'
