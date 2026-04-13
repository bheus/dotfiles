#!/bin/sh
#
# Zed
#
# Editor configuration

# Get the directory this script is in
ZED_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure .config directory exists
mkdir -p "$HOME/.config/zed"

# Symlink zed settings
ln -sf "$ZED_DIR/settings.json" "$HOME/.config/zed/settings.json"

echo "✓ Zed configured"

exit 0
