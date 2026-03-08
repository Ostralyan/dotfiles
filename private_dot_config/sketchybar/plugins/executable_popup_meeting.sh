#!/bin/bash

# Get next 3 upcoming events
EVENTS=$(icalBuddy -f -ea -n -li 3 -nc -nrd -npn -ps "/ | /" -po "datetime,title" -iep "datetime,title" eventsFrom:today to:tomorrow 2>/dev/null)

LINE1="No upcoming meetings"
LINE2=""
LINE3=""

if [ -n "$EVENTS" ]; then
  LINE1=$(echo "$EVENTS" | sed -n '1p' | sed 's/^ *//;s/ *$//')
  LINE2=$(echo "$EVENTS" | sed -n '2p' | sed 's/^ *//;s/ *$//')
  LINE3=$(echo "$EVENTS" | sed -n '3p' | sed 's/^ *//;s/ *$//')
fi

sketchybar --set meeting.line1 label="${LINE1:-No upcoming meetings}" \
           --set meeting.line2 label="${LINE2:- }" \
           --set meeting.line3 label="${LINE3:- }"
