#!/bin/sh
#
# AeroSpace + JankyBorders
#
# - Symlinks aerospace.toml into ~/.config/aerospace
# - Symlinks the two LaunchAgents that supervise JankyBorders and the
#   dark-mode watcher into ~/Library/LaunchAgents and (re)loads them.
#
# Note: borders requires Accessibility permission in System Settings →
# Privacy & Security. Grant it the first time the app prompts.

AEROSPACE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"

# AeroSpace config
mkdir -p "$HOME/.config/aerospace"
ln -sf "$AEROSPACE_DIR/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

# LaunchAgents
mkdir -p "$LAUNCH_AGENTS"
for label in com.bheussler.borders com.bheussler.borders-darknotify; do
    plist="$AEROSPACE_DIR/$label.plist"
    target="$LAUNCH_AGENTS/$label.plist"
    ln -sf "$plist" "$target"

    # Reload: bootout if already loaded, then bootstrap.
    launchctl bootout "gui/$UID/$label" 2>/dev/null || true
    launchctl bootstrap "gui/$UID" "$target" 2>/dev/null || \
        launchctl load -w "$target"
done

echo "✓ AeroSpace + JankyBorders configured"

exit 0
