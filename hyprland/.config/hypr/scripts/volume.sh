#!/bin/sh

down() {
pamixer -d 2
volume=$(pamixer --get-volume)
[$volume -gt 0 ] && volume=`expr $volume`  
notify-send "Volume $volume%"
}

up() {
pamixer -i 2
volume=$(pamixer --get-volume)
[ $volume -lt 100 ] && volume=`expr $volume`  
notify-send "Volume $volume%"
}

mute() {
muted="$(pamixer --get-mute)"
if $muted; then
  pamixer -u
  notify-send "Unmuted"
else 
  pamixer -m
  notify-send "Muted"
fi
}

case "$1" in
  up) up;;
  down) down;;
  mute) mute;;
esac
