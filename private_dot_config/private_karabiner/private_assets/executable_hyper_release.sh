#!/bin/bash

ACTION_FILE="/tmp/hyper_action"

if [ -f "$ACTION_FILE" ]; then
  ACTION=$(cat "$ACTION_FILE")
  rm -f "$ACTION_FILE"

  case "$ACTION" in
    gh) open "https://github.com/dideroai/didero" ;;
  esac
fi

/opt/homebrew/bin/sketchybar --set hyper icon.background.color=0xff585b70 icon.color=0xff1e1e2e label='' label.color=0xff585b70 label.padding_left=0
