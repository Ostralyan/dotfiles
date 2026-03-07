#!/bin/bash

if [ "$SENDER" = "mouse.entered" ]; then
  sketchybar --set $NAME popup.drawing=on
  $CONFIG_DIR/plugins/popup_stock.sh
  exit 0
elif [ "$SENDER" = "mouse.exited" ]; then
  sketchybar --set $NAME popup.drawing=off
  exit 0
fi

STOCKS_FILE="$CONFIG_DIR/plugins/.stock_index"
STOCKS=("META" "PCOR")

# Read current index
INDEX=0
if [ -f "$STOCKS_FILE" ]; then
  INDEX=$(cat "$STOCKS_FILE")
fi

# Ensure valid index
if [ "$INDEX" -ge "${#STOCKS[@]}" ] || [ "$INDEX" -lt 0 ]; then
  INDEX=0
fi

SYMBOL="${STOCKS[$INDEX]}"

# Fetch data from Yahoo Finance
DATA=$(curl -s -A "Mozilla/5.0" "https://query1.finance.yahoo.com/v8/finance/chart/$SYMBOL?range=1d&interval=1d")

PRICE=$(echo "$DATA" | grep -oE '"regularMarketPrice":[0-9.]+' | head -1 | cut -d: -f2)
PREV=$(echo "$DATA" | grep -oE '"chartPreviousClose":[0-9.]+' | head -1 | cut -d: -f2)

if [ -z "$PRICE" ]; then
  sketchybar --set "$NAME" icon="$SYMBOL" label="--"
  exit 0
fi

PRICE_FMT=$(printf "%.2f" "$PRICE")

# Compare to previous close
if [ -n "$PREV" ]; then
  UP=$(echo "$PRICE > $PREV" | bc -l)
  if [ "$UP" -eq 1 ]; then
    COLOR="0xffa6e3a1"  # green
  else
    COLOR="0xfff38ba8"  # red
  fi
else
  COLOR="0xffa6e3a1"
fi

sketchybar --set "$NAME" icon="$SYMBOL" label="\$$PRICE_FMT" \
  background.border_color="$COLOR" icon.color="$COLOR" label.color="$COLOR"
