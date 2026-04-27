#!/bin/sh
#
# borders.sh
#
# Invoked by dark-notify on appearance change. Just kills the running
# borders process — launchd (com.bheussler.borders) respawns it via
# borders-run.sh, which picks up the new appearance.

pkill -x borders 2>/dev/null || true
