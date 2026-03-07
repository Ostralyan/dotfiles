#!/bin/bash

# Active workspace: mauve pill with label
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME drawing=on \
    background.drawing=on \
    background.color=0xffcba6f7 \
    background.corner_radius=6 \
    background.height=24 \
    icon.color=0xff1e1e2e \
    icon.padding_right=2 \
    label.drawing=on \
    label.color=0xff1e1e2e
  exit 0
fi

# Previous workspace: collapse, check if empty
if [ "$1" = "$PREV_WORKSPACE" ]; then
  WINDOWS=$(aerospace list-windows --workspace "$1" 2>/dev/null | wc -l)
  if [ "$WINDOWS" -eq 0 ]; then
    sketchybar --set $NAME drawing=off background.drawing=off label.drawing=off
  else
    sketchybar --set $NAME drawing=on background.drawing=off \
      icon.color=0xff6c7086 icon.padding_right=10 label.drawing=off
  fi
  exit 0
fi

# All other workspaces: compact, no label
sketchybar --set $NAME background.drawing=off icon.color=0xff6c7086 \
  icon.padding_right=10 label.drawing=off
