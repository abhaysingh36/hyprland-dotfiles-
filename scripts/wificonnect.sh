#!/bin/bash

# Unblock Wi-Fi in case it's blocked
rfkill unblock all

# Power on wlan0
iwctl device wlan0 set-property Powered on

# Scan for networks
iwctl station wlan0 scan

# Show available networks
echo "Available networks:"
iwctl station wlan0 get-networks

# Ask user for SSID
read -p "Enter Wi-Fi SSID: " ssid

# Connect to the chosen SSID
iwctl station wlan0 connect "$ssid"

