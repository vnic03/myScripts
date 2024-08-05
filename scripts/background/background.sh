#!/bin/bash

# Explanation on how to use in README.md 

# Define the directories where your wallpapers are located
BACKGROUND_DIR_LEFT="your/image/path/left"
BACKGROUND_DIR_RIGHT="your/image/path/right_or_single"

BACKGROUND_LEFT=($(find "$BACKGROUND_DIR_LEFT" -mindepth 1 -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \)))
BACKGROUND_RIGHT=($(find "$BACKGROUND_DIR_RIGHT" -mindepth 1 -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \)))

shuffle() {
  local array_name=$1
  local size rand tmp

  eval "size=\${#${array_name}[@]}"
  for ((i=size-1; i>0; i--)); do
    rand=$((RANDOM % (i+1)))
    eval "tmp=\${${array_name}[i]}"
    eval "${array_name}[i]=\${${array_name}[rand]}"
    eval "${array_name}[rand]=\$tmp"
  done
}

shuffle BACKGROUND_LEFT
shuffle BACKGROUND_RIGHT

STOP="/tmp/stop-r-b"

[ ! -f "$STOP" ] && touch "$STOP"

num_monitors=$(xrandr --listmonitors | grep "Monitors:" | cut -d ' ' -f 2)

while true; do
  [ -f "$STOP" ] && exit 0

  for ((i=0; i<${#BACKGROUND_LEFT[@]}; i++)); do
    [ -f "$STOP" ] && exit 0

    LEFT_WALLPAPER=${BACKGROUND_LEFT[i]}
    RIGHT_WALLPAPER=${BACKGROUND_RIGHT[i % ${#BACKGROUND_RIGHT[@]}]}

    if [ "$num_monitors" -gt 1 ]; then
      flatpak run org.gabmus.hydrapaper -c "$RIGHT_WALLPAPER" "$LEFT_WALLPAPER"
    else
      mode=$(gsettings get org.gnome.desktop.interface color-scheme)
      if [ "$mode" = "'prefer-light'" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$RIGHT_WALLPAPER"
      else
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$RIGHT_WALLPAPER"
      fi
    fi

    # Change Interval to whatever you want
    sleep 45

  done

  shuffle BACKGROUND_LEFT
  shuffle BACKGROUND_RIGHT

done
