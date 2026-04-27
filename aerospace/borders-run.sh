#!/bin/sh
#
# borders-run.sh
#
# Foreground runner for JankyBorders, supervised by launchd
# (com.bheussler.borders). Reads the current macOS appearance and execs
# borders. When `borders.sh` kills the running borders on appearance
# change, launchd respawns this script and the new appearance is picked
# up here.

if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark; then
    active=0xffe1e3e4
    inactive=0xff494d64
else
    active=0xff1a1a1a
    inactive=0xffb0b0b0
fi

exec /opt/homebrew/bin/borders \
    active_color="$active" \
    inactive_color="$inactive" \
    width=5.0
