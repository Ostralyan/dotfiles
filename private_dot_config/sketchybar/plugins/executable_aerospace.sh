#!/bin/bash

# Active workspace: full height highlight
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME drawing=on \
    background.drawing=on \
    background.color=0xffcba6f7 \
    background.height=40 \
    background.corner_radius=0 \
    icon.color=0xff1e1e2e
  exit 0
fi

# Previous workspace: check if empty
if [ "$1" = "$PREV_WORKSPACE" ]; then
  WINDOWS=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l)
  if [ "$WINDOWS" -eq 0 ]; then
    sketchybar --set $NAME drawing=off background.drawing=off
  else
    sketchybar --set $NAME drawing=on background.drawing=off icon.color=0xff6c7086
  fi
  exit 0
fi

# All other workspaces: dimmed
sketchybar --set $NAME background.drawing=off icon.color=0xff6c7086
