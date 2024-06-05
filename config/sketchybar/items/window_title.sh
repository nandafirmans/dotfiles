# E V E N T S
sketchybar --add event window_focus \
           --add event title_change


sketchybar --add item title_separator left                             \
           --set title_separator icon="􀀁"                                \
                                 icon.font="SF Pro:Semibold:4.0" \
                                 icon.color=$FONT_COLOR_INACTIVE                     \
                                 icon.padding_left=6                   \
                                 icon.padding_right=18                   \
                                 padding_right=0                   \
                                 padding_left=-12                   \
                                 label.drawing=off                     \
                                 background.corner_radius=0 \
                                 background.drawing=on                \

# W I N D O W  T I T L E 
sketchybar -m --add item title left \
              --set title icon.font="sketchybar-app-font:Regular:13.0" \
                        background.drawing=on \
                        padding_left=-8 \
                        label.padding_left=0 \
                        label.padding_right=12 \
                        icon.drawing=off \
                        script="$HOME/.config/sketchybar/plugins/window_title.sh" \
              --subscribe title window_focus front_app_switched space_change title_change
