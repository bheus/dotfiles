#!/bin/sh
#
# Micro
#
# Terminal text editor configuration

MICRO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p "$HOME/.config/micro"

ln -sf "$MICRO_DIR/settings.json" "$HOME/.config/micro/settings.json"

echo "✓ Micro configured"

exit 0
