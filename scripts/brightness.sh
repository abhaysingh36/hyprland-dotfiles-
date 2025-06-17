#!/bin/bash

# Get current brightness percentage
CURRENT_BRIGHTNESS=$(brightnessctl -m | awk -F, '{print $6}' | tr -d '%')
STEP=7

# Handle click events
case "$3" in
    "up")
        brightnessctl set +${STEP}%
        ;;
    "down")
        brightnessctl set ${STEP}%-
        ;;
esac

# Output JSON for Waybar
echo "{\"text\": \" ${CURRENT_BRIGHTNESS}%\", \"percentage\": ${CURRENT_BRIGHTNESS}}"
