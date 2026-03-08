#!/bin/bash

MEETING_URL_FILE="$CONFIG_DIR/plugins/.meeting_url"

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_meeting.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

# Get the next upcoming event with notes/url to find meeting link
STRIP_ANSI='s/\x1b\[[0-9;]*m//g'
NEXT=$(icalBuddy -f -ea -n -li 1 -nc -nrd -npn -ps "/ | /" -po "datetime,title" -iep "datetime,title" eventsFrom:today to:tomorrow 2>/dev/null | sed -E "$STRIP_ANSI")
DETAILS=$(icalBuddy -f -ea -n -li 1 -nc -nrd -npn -iep "notes,url,location" eventsFrom:today to:tomorrow 2>/dev/null | sed -E "$STRIP_ANSI")

# Extract meeting URL (Google Meet, Zoom, Teams, Webex)
MEET_URL=$(echo "$DETAILS" | grep -oE 'https://meet\.google\.com/[a-z0-9-]+' | head -1)
if [ -z "$MEET_URL" ]; then
  MEET_URL=$(echo "$DETAILS" | grep -oE 'https://[a-z0-9]+\.zoom\.us/j/[0-9?=&a-zA-Z]+' | head -1)
fi
if [ -z "$MEET_URL" ]; then
  MEET_URL=$(echo "$DETAILS" | grep -oE 'https://teams\.microsoft\.com/[^ "]+' | head -1)
fi
if [ -z "$MEET_URL" ]; then
  MEET_URL=$(echo "$DETAILS" | grep -oE 'https://[a-z0-9]+\.webex\.com/[^ "]+' | head -1)
fi

# Save URL for click script
if [ -n "$MEET_URL" ]; then
  echo "$MEET_URL" > "$MEETING_URL_FILE"
else
  echo "" > "$MEETING_URL_FILE"
fi

if [ -z "$NEXT" ]; then
  sketchybar --set "$NAME" label="No meetings" icon.background.color=0xff585b70
  exit 0
fi

# Title is after the " | " separator
TITLE=$(echo "$NEXT" | head -1 | sed 's/.*| //;s/^ *//;s/ *$//')

# Extract full date and time: "Mar 9, 2026 at 07:00"
DATE_TIME=$(echo "$NEXT" | head -1 | grep -oE '[A-Z][a-z]+ [0-9]+, [0-9]+ at [0-9]{1,2}:[0-9]{2}' | head -1)

if [ -z "$DATE_TIME" ]; then
  sketchybar --set "$NAME" label="$TITLE" icon.background.color=0xfffab387
  exit 0
fi

# Parse full date+time to epoch
# Format: "Mar 9, 2026 at 07:00"
MEETING_EPOCH=$(date -j -f "%b %d, %Y at %H:%M" "$DATE_TIME" +%s 2>/dev/null)
if [ -z "$MEETING_EPOCH" ]; then
  # Try single digit day with padding
  PADDED=$(echo "$DATE_TIME" | sed 's/\([A-Z][a-z]*\) \([0-9]\),/\1  \2,/')
  MEETING_EPOCH=$(date -j -f "%b %e, %Y at %H:%M" "$PADDED" +%s 2>/dev/null)
fi

NOW_EPOCH=$(date +%s)

if [ -n "$MEETING_EPOCH" ]; then
  DIFF=$(( (MEETING_EPOCH - NOW_EPOCH) / 60 ))

  if [ "$DIFF" -lt 0 ]; then
    LABEL="$TITLE (now)"
    COLOR="0xff585b70"
  elif [ "$DIFF" -eq 0 ]; then
    LABEL="$TITLE now!"
    COLOR="0xfff38ba8"
  elif [ "$DIFF" -le 5 ]; then
    LABEL="$TITLE in ${DIFF}m"
    COLOR="0xfff38ba8"
  elif [ "$DIFF" -le 15 ]; then
    LABEL="$TITLE in ${DIFF}m"
    COLOR="0xfff9e2af"
  elif [ "$DIFF" -le 60 ]; then
    LABEL="$TITLE in ${DIFF}m"
    COLOR="0xfffab387"
  else
    HOURS=$(( DIFF / 60 ))
    MINS=$(( DIFF % 60 ))
    LABEL="$TITLE in ${HOURS}h${MINS}m"
    COLOR="0xfffab387"
  fi
else
  LABEL="$TITLE"
  COLOR="0xfffab387"
fi

sketchybar --set "$NAME" label="$LABEL" icon.background.color="$COLOR"
