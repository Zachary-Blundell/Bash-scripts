#!/usr/bin/env bash
# Launch apps on specific Hyprland workspaces.
# workspace 1 -> Brave
# workspace 2 -> kitty
# workspace 4 -> Docker Desktop
# workspace 6 -> Spotify

set -euo pipefail

# --- tweak these if your binaries differ ---
BRAVE_CMD="brave" # sometimes 'brave-browser'
TERMINAL_CMD="kitty --execute zellij --layout=cdl"
DOCKER_DESKTOP_CMD="docker-credential-desktop"
SPOTIFY_CMD="spotify"

# Small delay so the app binds to the focused workspace
DELAY="${DELAY:-0.5}" # → “Use the value of $DELAY if it’s set and not empty; otherwise use 0.35.”

# Then we assign that result back into DELAY.
# If you do nothing, DELAY becomes 0.35.
# If you run with a custom value, e.g. DELAY=0.6 launch-setup.sh, then DELAY becomes 0.6.
# This plays nicely even with set -u (treat unset vars as errors): the :- form is safe and won’t error when DELAY is unset.
# Handy variants (for your Bash toolbox):
# ${var-default} (single -): uses default only when var is unset (empty string still counts as “set”).
# ${var:-default} (what we used): uses default when var is unset or empty.
# ${var:=default} / ${var:=…}: same as above but also assigns default to var if it was unset/empty.
# ${var:?message}: error out with message if var is unset/empty.
# Quick demo:
# unset DELAY
# echo "${DELAY:-0.35}"   # -> 0.35
# DELAY=                  # empty
# echo "${DELAY:-0.35}"   # -> 0.35
# DELAY=0.6
# echo "${DELAY:-0.35}"   # -> 0.6

launch_on_ws() {
  local ws="$1"
  shift
  local cmd=("$@")

  # Focus the target workspace, then exec the command via Hyprland
  hyprctl dispatch workspace "$ws"
  sleep "$DELAY"
  hyprctl dispatch exec -- "${cmd[@]}"
  sleep "$DELAY"
}

launch_on_ws 1 "$BRAVE_CMD"
launch_on_ws 2 "$TERMINAL_CMD"
launch_on_ws 4 "$DOCKER_DESKTOP_CMD"
launch_on_ws 6 "$SPOTIFY_CMD"

echo "All set 🎯"
