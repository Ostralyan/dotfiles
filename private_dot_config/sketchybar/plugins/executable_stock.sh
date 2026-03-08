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
CACHE_DIR="$CONFIG_DIR/plugins/.stock_cache"
STOCKS=("META" "PCOR" "GOOGL" "AAPL" "MSFT" "AVGO" "NVDA" "AMZN")
COUNT=${#STOCKS[@]}

mkdir -p "$CACHE_DIR"

# Rotate index
INDEX=0
if [ -f "$STOCKS_FILE" ]; then
  INDEX=$(cat "$STOCKS_FILE")
fi
INDEX=$(( (INDEX + 1) % COUNT ))
echo "$INDEX" > "$STOCKS_FILE"

SYMBOL="${STOCKS[$INDEX]}"
CACHE_FILE="$CACHE_DIR/$SYMBOL"

# Refresh cache if older than 5 minutes or missing
REFRESH=false
if [ ! -f "$CACHE_FILE" ]; then
  REFRESH=true
else
  AGE=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE") ))
  if [ "$AGE" -gt 300 ]; then
    REFRESH=true
  fi
fi

if [ "$REFRESH" = true ]; then
  DATA=$(curl -s -A "Mozilla/5.0" "https://query1.finance.yahoo.com/v8/finance/chart/$SYMBOL?range=1d&interval=1d")
  if [ -n "$DATA" ]; then
    echo "$DATA" > "$CACHE_FILE"
  fi
fi

DATA=$(cat "$CACHE_FILE" 2>/dev/null)
PRICE=$(echo "$DATA" | grep -oE '"regularMarketPrice":[0-9.]+' | head -1 | cut -d: -f2)
PREV=$(echo "$DATA" | grep -oE '"chartPreviousClose":[0-9.]+' | head -1 | cut -d: -f2)

if [ -z "$PRICE" ]; then
  sketchybar --set "$NAME" label="$SYMBOL --"
  exit 0
fi

PRICE_FMT=$(printf "%.2f" "$PRICE")

if [ -n "$PREV" ]; then
  UP=$(echo "$PRICE > $PREV" | bc -l)
  if [ "$UP" -eq 1 ]; then
    COLOR="0xffa6e3a1"
  else
    COLOR="0xfff38ba8"
  fi
else
  COLOR="0xffa6e3a1"
fi

sketchybar --set "$NAME" label="$SYMBOL \$$PRICE_FMT" \
  label.color="$COLOR" icon.background.color="$COLOR"
