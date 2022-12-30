#!/usr/bin/env sh

sketchybar --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
    --add item input right\
    --set input script="$PLUGIN_DIR/input.sh" \
          icon=􀇳 \
          icon.font="$FONT:Black:12.0"      \
    --subscribe input input_change 
