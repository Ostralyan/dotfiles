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
  9[0-9]|100) ICON="󰁹" ;;
  [6-8][0-9]) ICON="󰂁" ;;
  [3-5][0-9]) ICON="󰁿" ;;
  [1-2][0-9]) ICON="󰁻" ;;
  *)          ICON="󰁺" ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
