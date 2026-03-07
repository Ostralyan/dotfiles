#!/bin/bash

source "$CONFIG_DIR/plugins/icon_map.sh"

WS="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
NAME_LABEL="$(workspace_name "$WS")"

sketchybar --set $NAME label="$NAME_LABEL"
