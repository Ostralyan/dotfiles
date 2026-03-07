#!/bin/sh

BATT_INFO=$(pmset -g batt)
SOURCE=$(echo "$BATT_INFO" | head -1 | grep -oE "'.*'" | tr -d "'")
TIME_LEFT=$(echo "$BATT_INFO" | grep -oE "\d+:\d+ remaining" || echo "calculating...")
CYCLES=$(system_profiler SPPowerDataType 2>/dev/null | grep "Cycle Count" | awk '{print $3}')
CONDITION=$(system_profiler SPPowerDataType 2>/dev/null | grep "Condition" | awk '{print $2}')

sketchybar --set battery.line1 label="Source: ${SOURCE:-Unknown}" \
           --set battery.line2 label="Time: ${TIME_LEFT}" \
           --set battery.line3 label="Cycles: ${CYCLES:-?}  Health: ${CONDITION:-?}"
