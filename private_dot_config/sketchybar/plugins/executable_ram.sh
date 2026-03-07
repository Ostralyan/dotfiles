#!/bin/sh

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_ram.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

USED=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print 100 - $5}' | tr -d '%')
sketchybar --set "$NAME" label="${USED}%"
