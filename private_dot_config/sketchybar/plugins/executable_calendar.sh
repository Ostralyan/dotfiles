#!/bin/bash

OFFSET_FILE="$CONFIG_DIR/plugins/.cal_offset"

# Read month offset
OFFSET=0
if [ -f "$OFFSET_FILE" ]; then
  OFFSET=$(cat "$OFFSET_FILE")
fi

case "$1" in
  prev)
    OFFSET=$((OFFSET - 1))
    echo "$OFFSET" > "$OFFSET_FILE"
    ;;
  next)
    OFFSET=$((OFFSET + 1))
    echo "$OFFSET" > "$OFFSET_FILE"
    ;;
  show)
    ;;
esac

# Calculate target month/year
MONTH=$(date -v+"${OFFSET}m" "+%m" 2>/dev/null)
YEAR=$(date -v+"${OFFSET}m" "+%Y" 2>/dev/null)
TODAY=$(date "+%d" | sed 's/^0//')
CURRENT_MONTH=$(date "+%m")
CURRENT_YEAR=$(date "+%Y")

# Get calendar output
CAL=$(cal "$MONTH" "$YEAR" 2>/dev/null)

# Highlight today if viewing current month
if [ "$MONTH" = "$CURRENT_MONTH" ] && [ "$YEAR" = "$CURRENT_YEAR" ]; then
  # Surround today's date with brackets
  CAL=$(echo "$CAL" | sed -E "s/(^| )($TODAY)( |$)/\1[$TODAY]\3/")
fi

# Set each line
LINE=1
echo "$CAL" | while IFS= read -r row; do
  if [ $LINE -le 8 ]; then
    sketchybar --set clock.cal$LINE label="$row"
  fi
  LINE=$((LINE + 1))
done

# Clear remaining lines
TOTAL=$(echo "$CAL" | wc -l | tr -d ' ')
for i in $(seq $((TOTAL + 1)) 8); do
  sketchybar --set clock.cal$i label=""
done

# Keep popup open after clicking nav
sketchybar --set clock popup.drawing=on
