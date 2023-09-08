if [[ $(hyprctl -j getoption decoration:drop_shadow | jaq -r ".int") = "1"  ]]; then
  hyprctl --batch "keyword general:gaps_in 0 ; keyword general:gaps_out 0 ; keyword general:border_size 0 ; keyword decoration:rounding 0 ; keyword decoration:drop_shadow false ;"  # on
else 
  hyprctl --batch "keyword general:gaps_in 5 ; keyword general:gaps_out 5 ; keyword general:border_size 2 ; keyword decoration:rounding 10 ; keyword decoration:drop_shadow true ;"  # off
fi

