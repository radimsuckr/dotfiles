#!/bin/sh

pulseaudio --start
xset -b
setxkbmap cz
nitrogen --restore
compton -b

exec i3
