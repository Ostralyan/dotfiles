#!/bin/bash

workspace_icon() {
  case "$1" in
    1) echo "" ;;
    2) echo "󰖟" ;;
    3) echo "󰌱" ;;
    4) echo "󰷈" ;;
    B) echo "" ;;
    C) echo "󰚩" ;;
    D) echo "" ;;
    E) echo "" ;;
    W) echo "󰭹" ;;
    I) echo "" ;;
    M) echo "󰍥" ;;
    N) echo "󰎞" ;;
    O) echo "" ;;
    P) echo "" ;;
    Q) echo "󰗚" ;;
    R) echo "󰍬" ;;
    S) echo "󰒱" ;;
    *) echo "$1" ;;
  esac
}

ICONS_DIR="$HOME/.config/sketchybar/icons"

workspace_name() {
  case "$1" in
    1) echo "$ICONS_DIR/ghostty.png" ;;
    2) echo "$ICONS_DIR/dia.png" ;;
    3) echo "$ICONS_DIR/linear.png" ;;
    4) echo "$ICONS_DIR/marktext.png" ;;
    B) echo "$ICONS_DIR/beekeeper.png" ;;
    C) echo "$ICONS_DIR/claude.png" ;;
    D) echo "$ICONS_DIR/figma.png" ;;
    W) echo "$ICONS_DIR/chatgpt.png" ;;
    E) echo "$ICONS_DIR/notion.png" ;;
    R) echo "$ICONS_DIR/krisp.png" ;;
    Q) echo "$ICONS_DIR/beeper.png" ;;
    S) echo "$ICONS_DIR/slack.png" ;;
    *) echo "" ;;
  esac
}
