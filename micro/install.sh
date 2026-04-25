#!/bin/sh
#
# Micro
#
# Terminal text editor configuration

MICRO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p "$HOME/.config/micro/colorschemes"

ln -sf "$MICRO_DIR/settings.json" "$HOME/.config/micro/settings.json"

for scheme in "$MICRO_DIR"/colorschemes/*.micro; do
  ln -sf "$scheme" "$HOME/.config/micro/colorschemes/$(basename "$scheme")"
done

echo "✓ Micro configured"

exit 0
