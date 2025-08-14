#!/bin/bash

LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)

if [[ "$LEVEL" -lt 15 ]]; then
  notify-send "Battery Low" "Switching to power save mode"

  # Start power save mode using sudo
  if [[ $EUID -ne 0 ]]; then
    sudo tlp start
  else
    tlp start
  fi

  # Disable Hyprland blur (correct way)
  hyprctl keyword decoration:blur:enabled false
fi

