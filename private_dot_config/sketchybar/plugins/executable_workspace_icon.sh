#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

WS="$FOCUSED_WORKSPACE"
if [ -z "$WS" ]; then
  WS="$(aerospace list-workspaces --focused)"
fi

WS_ICON="$(workspace_name "$WS")"

sketchybar --set "$NAME" background.image="$WS_ICON"
