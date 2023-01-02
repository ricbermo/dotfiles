sketchybar  -m --add event bluetooth_change "com.apple.bluetooth.status" \
            --add item bluetooth right                                   \
            --set bluetooth script="$PLUGIN_DIR/bluetooth.sh"            \
                           click_script="$PLUGIN_DIR/bt_click.sh"        \
                           update_freq=5                                 \
            --subscribe bluetooth bluetooth_change
