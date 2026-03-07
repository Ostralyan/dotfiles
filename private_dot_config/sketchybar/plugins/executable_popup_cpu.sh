#!/bin/sh

PROCS=$(ps -Arceo %cpu,comm | head -6 | tail -5)

LINE=1
echo "$PROCS" | while read -r CPU CMD; do
  LABEL=$(printf "%-6s %s" "${CPU}%" "$CMD")
  sketchybar --set cpu.line$LINE label="$LABEL"
  LINE=$((LINE + 1))
done
