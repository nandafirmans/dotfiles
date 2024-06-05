#!/bin/bash

# W I N D O W  T I T L E 
WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.title')

WINDOW_APP_NAME=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r '.app')

if [[ $WINDOW_APP_NAME = "" ]]; then
  WINDOW_APP_NAME="—"
fi

WINDOW_ICON="$($CONFIG_DIR/plugins/icon_map_fn.sh "$WINDOW_APP_NAME")"

if [[ $WINDOW_TITLE = "" ]]; then
  WINDOW_TITLE=$WINDOW_APP_NAME
fi

if [[ ${#WINDOW_TITLE} -gt 38 ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-38)
  # sketchybar -m --set title icon="$WINDOW_ICON" label="$WINDOW_TITLE"…
  sketchybar -m --set title label="$WINDOW_TITLE"…
  exit 0
fi

# sketchybar -m --set title icon="$WINDOW_ICON" label="$WINDOW_TITLE"
sketchybar -m --set title label="$WINDOW_TITLE"
