#!/bin/bash

# Always show the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME drawing=on \
    background.drawing=on \
    background.color=0xffcba6f7 \
    background.corner_radius=6 \
    background.height=24 \
    icon.color=0xff1e1e2e \
    label.color=0xff1e1e2e
  exit 0
fi

# Hide previous workspace if it's now empty
if [ "$1" = "$PREV_WORKSPACE" ]; then
  WINDOWS=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l)
  if [ "$WINDOWS" -eq 0 ]; then
    sketchybar --set $NAME drawing=off background.drawing=off
  else
    sketchybar --set $NAME drawing=on background.drawing=off icon.color=0xff6c7086 label.color=0xff6c7086
  fi
  exit 0
fi

# All other workspaces stay dimmed
sketchybar --set $NAME background.drawing=off icon.color=0xff6c7086 label.color=0xff6c7086
