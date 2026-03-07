#!/bin/sh

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_cpu.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

CPU=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print int($3 + $5)}')
sketchybar --set "$NAME" label="${CPU}%"
