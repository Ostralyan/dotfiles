#!/bin/sh

FEELS=$(curl -s "wttr.in/?format=Feels+like:+%f" | sed 's/+/ /g')
HUMIDITY=$(curl -s "wttr.in/?format=Humidity:+%h" | sed 's/+/ /g')
WIND=$(curl -s "wttr.in/?format=Wind:+%w" | sed 's/+/ /g')
UV=$(curl -s "wttr.in/?format=UV+Index:+%u" | sed 's/+/ /g')

sketchybar --set weather.line1 label="${FEELS:-...}" \
           --set weather.line2 label="${HUMIDITY:-...}" \
           --set weather.line3 label="${WIND:-...}" \
           --set weather.line4 label="${UV:-...}"
