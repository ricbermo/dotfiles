#!/bin/sh

echo "install.sh is deprecated and no longer performs setup." >&2
echo "Use the phased bootstrap flow instead:" >&2
echo "  ./bootstrap.sh --brew" >&2
echo "  ./bootstrap.sh --dotfiles" >&2
echo "  ./bootstrap.sh --post" >&2
echo "or run everything with: ./bootstrap.sh --all" >&2

exit 1
