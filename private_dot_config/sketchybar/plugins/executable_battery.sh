#!/bin/bash

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_battery.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹"; COLOR="0xffa6e3a1" ;;
  [6-8][0-9]) ICON="󰂁"; COLOR="0xffa6e3a1" ;;
  [3-5][0-9]) ICON="󰁿"; COLOR="0xfff9e2af" ;;
  [1-2][0-9]) ICON="󰁻"; COLOR="0xfffab387" ;;
  *)          ICON="󰁺"; COLOR="0xfff38ba8" ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
  COLOR="0xffa6e3a1"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.background.color="$COLOR"
