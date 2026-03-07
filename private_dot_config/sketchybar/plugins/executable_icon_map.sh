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
    G) echo "󰭹" ;;
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

workspace_name() {
  case "$1" in
    1) echo "Ghostty" ;;
    2) echo "Dia" ;;
    3) echo "Linear" ;;
    4) echo "MarkText" ;;
    B) echo "Beekeeper" ;;
    C) echo "Claude" ;;
    D) echo "Figma" ;;
    G) echo "ChatGPT" ;;
    N) echo "Notion" ;;
    R) echo "Krisp" ;;
    S) echo "Slack" ;;
    *) echo "$1" ;;
  esac
}
