#!/bin/bash

INTERFACE=$(ip route | awk '/default/ {print $5}')  # Detect active network interface

RX1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

sleep 1

RX2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
TX2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

RX_DIFF=$((RX2 - RX1))
TX_DIFF=$((TX2 - TX1))

RX_SPEED=$(echo "scale=2; $RX_DIFF / (1024 * 1024)" | bc)
TX_SPEED=$(echo "scale=2; $TX_DIFF / (1024 * 1024)" | bc)

echo "⬇️ ${RX_SPEED} MB/s ⬆️ ${TX_SPEED} MB/s (Interface: $INTERFACE)"

