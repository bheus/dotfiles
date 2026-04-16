#!/bin/sh
#
# AeroSpace
#
# Tiling window manager configuration

# Get the directory this script is in
AEROSPACE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure .config directory exists
mkdir -p "$HOME/.config/aerospace"

# Symlink aerospace config
ln -sf "$AEROSPACE_DIR/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

echo "✓ AeroSpace configured"

exit 0
