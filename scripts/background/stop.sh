#!/bin/bash

BACKGROUND_LEFT="your/image/path/here/left"
BACKGROUND_RIGHT="your/image/path/here/right"

BACKGROUND="your/image/path/here/single"

STOP="/tmp/stop-r-b"

if [ ! -f "$STOP" ]; then
    touch "$STOP"
fi

num_monitors=$(xrandr --listmonitors | grep "Monitors:" | cut -d ' ' -f 2)

if [ "$num_monitors" -gt 1 ]; then
    flatpak run org.gabmus.hydrapaper -c "$BACKGROUND_RIGHT" "$BACKGROUND_LEFT"
else
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$BACKGROUND"
fi

for script in "random-background.sh" "r.sh"; do
    pids=$(pgrep -f "$script")
    for pid in $pids; do
        cmdline=$(tr '\0' ' ' < /proc/$pid/cmdline)
        if [[ $cmdline == *"$script"* && $pid != $$ ]]; then
            kill $pid
        fi
    done
done
