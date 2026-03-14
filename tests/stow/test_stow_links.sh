#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
PACKAGES_FILE="$ROOT_DIR/scripts/stow-packages.txt"

TARGET_LINKS=(
  ".zshrc"
  ".tmux.conf"
  ".gitconfig"
  ".aerospace.toml"
  ".config/sketchybar/init.lua"
  ".config/bat/config"
  ".config/tmuxai/config.yaml"
)
SOURCE_FILES=(
  "$ROOT_DIR/stow/zsh/.zshrc"
  "$ROOT_DIR/stow/tmux/.tmux.conf"
  "$ROOT_DIR/stow/git/.gitconfig"
  "$ROOT_DIR/stow/aerospace/.aerospace.toml"
  "$ROOT_DIR/stow/sketchybar/.config/sketchybar/init.lua"
  "$ROOT_DIR/stow/bat/.config/bat/config"
  "$ROOT_DIR/stow/tmuxai/.config/tmuxai/config.yaml"
)

assert_file_exists() {
  local path=$1

  if [ ! -f "$path" ]; then
    printf 'Expected file to exist: %s\n' "$path"
    exit 1
  fi
}

load_stow_packages() {
  local file_path=$1
  local line

  if [ ! -f "$file_path" ]; then
    printf 'Expected stow package list file: %s\n' "$file_path"
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
    printf 'Expected non-empty stow package list in %s\n' "$file_path"
    exit 1
  fi
}

assert_symlink_with_same_content() {
  local link_path=$1
  local source_path=$2

  if [ ! -L "$link_path" ]; then
    printf 'Expected symlink at: %s\n' "$link_path"
    exit 1
  fi

  if ! cmp -s "$link_path" "$source_path"; then
    printf 'Expected symlinked content at %s to match %s\n' "$link_path" "$source_path"
    exit 1
  fi
}

assert_symlink_points_into_stow_root() {
  local link_path=$1
  local expected_root=$2
  local target_path
  local target_dir
  local target_base
  local resolved_dir
  local resolved_path

  target_path=$(readlink "$link_path")

  case "$target_path" in
    /*) resolved_path=$target_path ;;
    *)
      target_dir=$(dirname -- "$target_path")
      target_base=$(basename -- "$target_path")
      resolved_dir=$(CDPATH= cd -- "$(dirname -- "$link_path")/$target_dir" && pwd)
      resolved_path="$resolved_dir/$target_base"
      ;;
  esac

  case "$resolved_path" in
    "$expected_root"/*) ;;
    *)
      printf 'Expected symlink target for %s to point into %s, got %s\n' "$link_path" "$expected_root" "$resolved_path"
      exit 1
      ;;
  esac
}

assert_symlink_target_matches_source() {
  local link_path=$1
  local source_path=$2
  local link_dir
  local target_path
  local resolved_target
  local source_dir
  local source_base
  local resolved_source

  link_dir=$(CDPATH= cd -- "$(dirname -- "$link_path")" && pwd)
  target_path=$(readlink "$link_path")

  case "$target_path" in
    /*) resolved_target=$target_path ;;
    *) resolved_target=$(CDPATH= cd -- "$link_dir/$(dirname -- "$target_path")" && pwd)/$(basename -- "$target_path") ;;
  esac

  source_dir=$(CDPATH= cd -- "$(dirname -- "$source_path")" && pwd)
  source_base=$(basename -- "$source_path")
  resolved_source="$source_dir/$source_base"

  if [ "$resolved_target" != "$resolved_source" ]; then
    printf 'Expected symlink target for %s to be %s, got %s\n' "$link_path" "$resolved_source" "$resolved_target"
    exit 1
  fi
}

load_stow_packages "$PACKAGES_FILE"

for source_file in "${SOURCE_FILES[@]}"; do
  assert_file_exists "$source_file"
done

if ! command -v stow >/dev/null 2>&1; then
  if [ "${REQUIRE_STOW:-0}" = "1" ]; then
    printf 'FAIL: stow command not found and REQUIRE_STOW=1. Install stow and re-run: stow --target "$HOME" --dir "%s/stow" %s\n' "$ROOT_DIR" "${STOW_PACKAGES[*]}"
    exit 1
  fi

  printf 'SKIP: stow command not found. Install stow and re-run: stow --target "$HOME" --dir "%s/stow" %s\n' "$ROOT_DIR" "${STOW_PACKAGES[*]}"
  printf 'SKIP: to enforce this in CI, run with REQUIRE_STOW=1.\n'
  exit 0
fi

TMP_HOME=$(mktemp -d)
trap 'rm -rf "$TMP_HOME"' EXIT

stow --target "$TMP_HOME" --dir "$ROOT_DIR/stow" "${STOW_PACKAGES[@]}"

for index in "${!TARGET_LINKS[@]}"; do
  target_link=${TARGET_LINKS[$index]}
  source_file=${SOURCE_FILES[$index]}
  assert_symlink_with_same_content "$TMP_HOME/$target_link" "$source_file"
  assert_symlink_points_into_stow_root "$TMP_HOME/$target_link" "$ROOT_DIR/stow"
  assert_symlink_target_matches_source "$TMP_HOME/$target_link" "$source_file"
done

printf 'PASS: stow creates expected dotfile links for packages: %s\n' "${STOW_PACKAGES[*]}"
