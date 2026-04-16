#!/bin/sh
#
# borders.sh
#
# Relaunch JankyBorders with colors matching the current macOS appearance.
# Invoked by AeroSpace at startup (no arg — mode is auto-detected) and by
# dark-notify on appearance change (passes "light" or "dark" as $1).

mode=${1:-}
if [ -z "$mode" ]; then
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
        mode=dark
    else
        mode=light
    fi
fi

case "$mode" in
    dark)
        active=0xffe1e3e4
        inactive=0xff494d64
        ;;
    *)
        active=0xff1a1a1a
        inactive=0xffb0b0b0
        ;;
esac

pkill -x borders 2>/dev/null || true
nohup borders active_color="$active" inactive_color="$inactive" width=5.0 >/dev/null 2>&1 &
