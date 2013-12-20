# Make key repeat rate not retarded.
xset r rate 250 30

# Disable annoying PC-speaker beeps.
xset -b

# Load X resources for urxvt
xrdb ~/.Xresources

# Keybinds
if [ -f $HOME/.Xmodmap ]; then
	/usr/bin/xmodmap $HOME/.Xmodmap
fi

#openbox-session

# Start the window manager.
python2 ~/Projects/qtile/bin/qtile &

~/.bin/quit-wait

