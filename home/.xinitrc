# Make key repeat rate not retarded.
xset r rate 250 30

# Load X resources for urxvt
xrdb ~/.Xresources

# Keybinds
if [ -f $HOME/.Xmodmap ]; then
	/usr/bin/xmodmap $HOME/.Xmodmap
fi

#openbox-session

# Start the window manager.
qtile &

~/.config/qtile/quit-wait

