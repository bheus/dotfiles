#!/bin/sh
#
# Ghostty
#
# Terminal emulator configuration

# Get the directory this script is in
GHOSTTY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure .config directory exists
mkdir -p "$HOME/.config/ghostty"

# Symlink ghostty config
ln -sf "$GHOSTTY_DIR/config" "$HOME/.config/ghostty/config"

echo "✓ Ghostty configured"

exit 0
