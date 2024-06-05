INFO="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //")"

if [[ $INFO = "You are not associated with an AirPort network." ]]; then
  INFO=""
fi

WIFI=${INFO:-"Not Connected"}

sketchybar --set $NAME label="${WIFI}"
