#!/bin/bash

MEETING_URL_FILE="$CONFIG_DIR/plugins/.meeting_url"

URL=""
if [ -f "$MEETING_URL_FILE" ]; then
  URL=$(cat "$MEETING_URL_FILE")
fi

if [ -n "$URL" ]; then
  open "$URL"
else
  open -a Calendar
fi
