#!/bin/bash

weather=(
  update_freq=600
  script="$PLUGIN_DIR/weather.sh"
  icon.font="Liga SFMono Nerd Font:Regular:13.0"
  background.drawing=on
  padding_left=15
)

sketchybar -m --add item weather right --set  weather "${weather[@]}"
