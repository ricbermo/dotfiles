#!/usr/bin/env sh

sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status"      \
              --add item headphones right                                    \
              --set headphones icon="􀺹 " script="$PLUGIN_DIR/ble_headset.sh" \
              --subscribe headphones bluetooth_change
