#!/bin/bash

INFO=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I 2>/dev/null)

SSID=$(echo "$INFO" | awk -F': ' '/ SSID/{print $2}')
BSSID=$(echo "$INFO" | awk -F': ' '/BSSID/{print $2}')
CHANNEL=$(echo "$INFO" | awk -F': ' '/channel/{print $2}')
RSSI=$(echo "$INFO" | awk -F': ' '/agrCtlRSSI/{print $2}')
NOISE=$(echo "$INFO" | awk -F': ' '/agrCtlNoise/{print $2}')
TXRATE=$(echo "$INFO" | awk -F': ' '/lastTxRate/{print $2}')

# Signal quality
if [ -n "$RSSI" ]; then
  if [ "$RSSI" -ge -50 ]; then
    QUALITY="Excellent"
  elif [ "$RSSI" -ge -60 ]; then
    QUALITY="Good"
  elif [ "$RSSI" -ge -70 ]; then
    QUALITY="Fair"
  else
    QUALITY="Weak"
  fi
  SIG="${RSSI}dBm ($QUALITY)"
else
  SIG="N/A"
fi

IP=$(ipconfig getifaddr en0 2>/dev/null)

sketchybar --set wifi.line1 label="Signal: $SIG" \
           --set wifi.line2 label="Speed:  ${TXRATE:-?} Mbps" \
           --set wifi.line3 label="IP:     ${IP:-N/A}" \
           --set wifi.line4 label="Ch:     ${CHANNEL:-?}"
