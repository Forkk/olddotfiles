#!/bin/bash

# Make key repeat rate not retarded.
xset r rate 250 42

# Set the cursor.
xsetroot -cursor_name left_ptr

# Disable annoying PC-speaker beeps.
xset -b

# Load X resources for urxvt
xrdb ~/.Xresources

# Keybinds
if [ -f $HOME/.Xmodmap ]; then
	/usr/bin/xmodmap $HOME/.Xmodmap
fi

# Set the wallpaper.
feh --bg-fill ~/.wallpaper/yosemite-waterfall.jpg

# Audio
pulseaudio --start

# Compositing
compton -b --config .compton.conf

# Start the window manager.
xmonad &

# Don't turn off my damn screen!
xset -dpms
xset s off

# System Tray
~/.xmonad/tray.sh &

# Run startup apps.
screencloud &
dropboxd &


~/.bin/hevents /tmp/hevents`echo $DISPLAY | tr ':' '_'`

