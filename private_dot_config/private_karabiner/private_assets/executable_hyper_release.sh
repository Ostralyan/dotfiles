#!/bin/bash

ACTION_FILE="/tmp/hyper_action"
BUFFER_FILE="/tmp/hyper_buffer"
CHORD_FILE="/tmp/hyper_chord_mode"

# If in chord mode (entered via double-tap), don't reset sketchybar
# The enter/escape handlers will clean up instead
if [ -f "$CHORD_FILE" ]; then
  exit 0
fi

# Execute staged action if present
if [ -f "$ACTION_FILE" ]; then
  eval "$(cat "$ACTION_FILE")"
fi

rm -f "$ACTION_FILE" "$BUFFER_FILE"

/opt/homebrew/bin/sketchybar --set hyper icon.background.color=0xff585b70 icon.color=0xff1e1e2e label='' label.color=0xff585b70 label.padding_left=0
