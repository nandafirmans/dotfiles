#!/bin/bash

sketchybar --add item calendar center \
           --set calendar icon=􀧞  \
                          update_freq=30 \
                          script="$PLUGIN_DIR/calendar.sh"
