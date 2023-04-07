#!/usr/bin/env bash
sketchybar --add item wifi right                         \
           --set wifi    script="$PLUGIN_DIR/wifi.sh"    \
                         update_freq=5
