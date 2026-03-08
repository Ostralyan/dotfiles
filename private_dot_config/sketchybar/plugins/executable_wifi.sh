#!/bin/bash

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_wifi.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I 2>/dev/null | awk -F': ' '/ SSID/{print $2}')

if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" icon="󰤭" label="Off" icon.background.color=0xfff38ba8
else
  sketchybar --set "$NAME" icon="󰤨" label="$SSID" icon.background.color=0xfff9e2af
fi
