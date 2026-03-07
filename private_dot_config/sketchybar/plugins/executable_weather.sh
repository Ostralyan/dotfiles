#!/bin/sh

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_weather.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

CONDITION=$(curl -s "wttr.in/?format=%C" | tr '[:upper:]' '[:lower:]')
TEMP=$(curl -s "wttr.in/?format=%t" | sed 's/+//')

if [ -z "$TEMP" ]; then
  exit 0
fi

case "$CONDITION" in
  *sunny*|*clear*)          ICON="󰖙" ;;
  *partly*cloudy*)          ICON="󰖕" ;;
  *cloudy*|*overcast*)      ICON="󰖐" ;;
  *fog*|*mist*|*haze*)      ICON="󰖑" ;;
  *rain*|*drizzle*|*shower*) ICON="󰖗" ;;
  *thunder*|*storm*)        ICON="󰖓" ;;
  *snow*|*sleet*|*blizzard*) ICON="󰖘" ;;
  *)                        ICON="󰖐" ;;
esac

sketchybar --set "$NAME" icon.drawing=on icon="$ICON" label="${CONDITION} ${TEMP}"
