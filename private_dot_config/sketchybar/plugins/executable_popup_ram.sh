#!/bin/sh

MEM_INFO=$(vm_stat | tail -n +2)
PAGE_SIZE=16384

ACTIVE=$(echo "$MEM_INFO" | grep "Pages active" | awk '{print $3}' | tr -d '.')
WIRED=$(echo "$MEM_INFO" | grep "Pages wired" | awk '{print $4}' | tr -d '.')
COMPRESSED=$(echo "$MEM_INFO" | grep "Pages occupied by compressor" | awk '{print $5}' | tr -d '.')
FREE=$(echo "$MEM_INFO" | grep "Pages free" | awk '{print $3}' | tr -d '.')

ACTIVE_GB=$(echo "scale=1; $ACTIVE * $PAGE_SIZE / 1073741824" | bc)
WIRED_GB=$(echo "scale=1; $WIRED * $PAGE_SIZE / 1073741824" | bc)
COMP_GB=$(echo "scale=1; $COMPRESSED * $PAGE_SIZE / 1073741824" | bc)
FREE_GB=$(echo "scale=1; $FREE * $PAGE_SIZE / 1073741824" | bc)

sketchybar --set ram.line1 label="Active:     ${ACTIVE_GB}GB" \
           --set ram.line2 label="Wired:      ${WIRED_GB}GB" \
           --set ram.line3 label="Compressed: ${COMP_GB}GB" \
           --set ram.line4 label="Free:       ${FREE_GB}GB"
