#!/bin/sh
#
# Karabiner-Elements
#
# Key remapping configuration (caps lock -> hyper modifier)

KARABINER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p "$HOME/.config/karabiner"

ln -sf "$KARABINER_DIR/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

echo "✓ Karabiner-Elements configured"

exit 0
