#!/bin/bash

STOCKS_FILE="$CONFIG_DIR/plugins/.stock_index"
STOCKS=("META" "PCOR" "GOOGL" "AAPL" "MSFT" "AVGO" "NVDA")
COUNT=${#STOCKS[@]}

# Read current index
INDEX=0
if [ -f "$STOCKS_FILE" ]; then
  INDEX=$(cat "$STOCKS_FILE")
fi

# Right click (BUTTON=right) = forward, left click = backward
if [ "$BUTTON" = "right" ]; then
  INDEX=$(( (INDEX + 1) % COUNT ))
else
  INDEX=$(( (INDEX - 1 + COUNT) % COUNT ))
fi

echo "$INDEX" > "$STOCKS_FILE"

# Trigger a refresh
$CONFIG_DIR/plugins/stock.sh
