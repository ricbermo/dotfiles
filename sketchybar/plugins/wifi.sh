#!/usr/bin/env sh

# CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
# SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"

SSID="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //")"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="" icon="􀙈 "
else
  sketchybar --set $NAME label="$SSID" icon="􀙇 " label.padding_right=7
fi
