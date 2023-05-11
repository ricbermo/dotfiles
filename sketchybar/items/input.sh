#!/usr/bin/env sh

sketchybar --add item input right                    \
           --add event input_change 'AppleSelectedInputSourcesChangedNotification' \
           --set input icon="􀇳"  script="$PLUGIN_DIR/input.sh" \
           --subscribe input input_change
