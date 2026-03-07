#!/bin/bash

STOCKS_FILE="$CONFIG_DIR/plugins/.stock_index"
STOCKS=("META" "PCOR")

INDEX=0
if [ -f "$STOCKS_FILE" ]; then
  INDEX=$(cat "$STOCKS_FILE")
fi
if [ "$INDEX" -ge "${#STOCKS[@]}" ] || [ "$INDEX" -lt 0 ]; then
  INDEX=0
fi

SYMBOL="${STOCKS[$INDEX]}"
DATA=$(curl -s -A "Mozilla/5.0" "https://query1.finance.yahoo.com/v8/finance/chart/$SYMBOL?range=1d&interval=1d")

PRICE=$(echo "$DATA" | grep -oE '"regularMarketPrice":[0-9.]+' | head -1 | cut -d: -f2)
PREV=$(echo "$DATA" | grep -oE '"chartPreviousClose":[0-9.]+' | head -1 | cut -d: -f2)
HIGH=$(echo "$DATA" | grep -oE '"regularMarketDayHigh":[0-9.]+' | head -1 | cut -d: -f2)
LOW=$(echo "$DATA" | grep -oE '"regularMarketDayLow":[0-9.]+' | head -1 | cut -d: -f2)
VOL=$(echo "$DATA" | grep -oE '"regularMarketVolume":[0-9]+' | head -1 | cut -d: -f2)

CHANGE="--"; PCT="--"
if [ -n "$PREV" ] && [ -n "$PRICE" ]; then
  CHANGE=$(printf "%.2f" "$(echo "$PRICE - $PREV" | bc -l)")
  PCT=$(printf "%.2f" "$(echo "($PRICE - $PREV) / $PREV * 100" | bc -l)")
fi

HIGH_FMT=$(printf "%.2f" "${HIGH:-0}")
LOW_FMT=$(printf "%.2f" "${LOW:-0}")

sketchybar --set stock.line1 label="Change: \$${CHANGE} (${PCT}%)" \
           --set stock.line2 label="High:   \$${HIGH_FMT}" \
           --set stock.line3 label="Low:    \$${LOW_FMT}" \
           --set stock.line4 label="Volume: ${VOL:-0}"
