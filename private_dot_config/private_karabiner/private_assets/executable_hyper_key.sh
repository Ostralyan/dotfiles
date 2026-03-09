#!/bin/bash

# Harp — hyper key chord handler
# Reads chord definitions from ~/.config/harp/harp.toml
# Matching: longest exact match wins, then args-based prefix match.

SKETCHYBAR=/opt/homebrew/bin/sketchybar
BUFFER_FILE="/tmp/hyper_buffer"
ACTION_FILE="/tmp/hyper_action"
CONFIG="$HOME/.config/harp/harp.toml"
KEY="$1"

# Read current buffer
BUFFER=""
[ -f "$BUFFER_FILE" ] && BUFFER=$(cat "$BUFFER_FILE")

if [ "$KEY" = "backspace" ]; then
  if [ -n "$BUFFER" ]; then
    BUFFER="${BUFFER%?}"
    echo -n "$BUFFER" > "$BUFFER_FILE"
    rm -f "$ACTION_FILE"
  fi
else
  BUFFER="${BUFFER}${KEY}"
  echo -n "$BUFFER" > "$BUFFER_FILE"
fi

# Parse all chords from config
CHORD_NAMES=()
CHORD_LABELS=()
CHORD_ACTIONS=()
CHORD_ARGS=()
CUR_NAME=""
CUR_LABEL=""
CUR_ACTION=""
CUR_ARGS="false"

flush_chord() {
  if [ -n "$CUR_NAME" ]; then
    CHORD_NAMES+=("$CUR_NAME")
    CHORD_LABELS+=("$CUR_LABEL")
    CHORD_ACTIONS+=("$CUR_ACTION")
    CHORD_ARGS+=("$CUR_ARGS")
  fi
  CUR_NAME="" CUR_LABEL="" CUR_ACTION="" CUR_ARGS="false"
}

while IFS= read -r line; do
  line="${line%%#*}"
  line="$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  [ -z "$line" ] && continue

  # Match [chords.name] or [chords."name with spaces"]
  if [[ "$line" =~ ^\[chords\.\"?([^]\"]+)\"?\]$ ]]; then
    flush_chord
    CUR_NAME="${BASH_REMATCH[1]}"
    continue
  fi

  if [ -n "$CUR_NAME" ]; then
    if [[ "$line" =~ ^label[[:space:]]*=[[:space:]]*[\"\'](.+)[\"\']$ ]]; then
      CUR_LABEL="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^action[[:space:]]*=[[:space:]]*[\"\'](.+)[\"\']$ ]]; then
      CUR_ACTION="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^args[[:space:]]*=[[:space:]]*true$ ]]; then
      CUR_ARGS="true"
    fi
  fi
done < "$CONFIG"
flush_chord

# 1. Find longest exact match
BEST_IDX=""
BEST_LEN=0
for i in "${!CHORD_NAMES[@]}"; do
  name="${CHORD_NAMES[$i]}"
  if [ "${CHORD_ARGS[$i]}" = "false" ] && [ "$BUFFER" = "$name" ]; then
    if [ ${#name} -gt $BEST_LEN ]; then
      BEST_LEN=${#name}
      BEST_IDX=$i
    fi
  fi
done

if [ -n "$BEST_IDX" ]; then
  echo "${CHORD_ACTIONS[$BEST_IDX]}" > "$ACTION_FILE"
  $SKETCHYBAR --set hyper label="${CHORD_LABELS[$BEST_IDX]}"
  exit 0
fi

# 2. Find longest args-based prefix match
BEST_IDX=""
BEST_LEN=0
for i in "${!CHORD_NAMES[@]}"; do
  name="${CHORD_NAMES[$i]}"
  if [ "${CHORD_ARGS[$i]}" = "true" ]; then
    # Match "name" exactly or "name " prefix
    if [ "$BUFFER" = "$name" ] || [[ "$BUFFER" = "$name "* ]]; then
      if [ ${#name} -gt $BEST_LEN ]; then
        BEST_LEN=${#name}
        BEST_IDX=$i
      fi
    fi
  fi
done

if [ -n "$BEST_IDX" ]; then
  name="${CHORD_NAMES[$BEST_IDX]}"
  ARG="${BUFFER#$name }"
  [ "$ARG" = "$BUFFER" ] && ARG=""

  ACTION="${CHORD_ACTIONS[$BEST_IDX]//\{arg\}/$ARG}"
  echo "$ACTION" > "$ACTION_FILE"

  if [ -n "$ARG" ]; then
    $SKETCHYBAR --set hyper label="${CHORD_LABELS[$BEST_IDX]}: ${ARG}"
  else
    $SKETCHYBAR --set hyper label="${CHORD_LABELS[$BEST_IDX]} ..."
  fi
  exit 0
fi

# 3. No match — show buffer
rm -f "$ACTION_FILE"
if [ -n "$BUFFER" ]; then
  $SKETCHYBAR --set hyper label="${BUFFER}..."
else
  $SKETCHYBAR --set hyper label='Chord...'
fi
