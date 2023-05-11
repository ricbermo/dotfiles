#!/usr/bin/env sh

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

echo $SOURCE
case ${SOURCE} in
'com.apple.keylayout.ABC') LABEL='US' ;;
'com.apple.keylayout.US') LABEL='US' ;;
'com.apple.keylayout.Spanish-ISO') LABEL='ES' ;;
esac

sketchybar --set $NAME label="$LABEL" background.padding_right=20
