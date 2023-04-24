#!/bin/bash

DEVICES=$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType == "Headphones" or .device_minorType == "Headset") | keys[]')
CONNECTED="$(echo "$DEVICES" | sed 's/"//g')"

if [ "$CONNECTED" = "" ]; then
  sketchybar --set $NAME icon.drawing=off background.padding_right=0 background.padding_left=0 label.drawing=off
else
  sketchybar --set $NAME icon.drawing=on label=$CONNECTED label.padding_right=10 icon.padding_left=5
fi
