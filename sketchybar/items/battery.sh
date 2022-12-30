#!/usr/bin/env sh

sketchybar  --add item battery right \
            --set battery \
                        icon.font="$FONT:Black:12.0" \
                        update_freq=10 \
                        script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke
