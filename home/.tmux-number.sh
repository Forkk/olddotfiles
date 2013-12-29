#!/bin/bash

# This is a quick script for rearranging tmux windows.
# This is necessary because if I close a window in tmux which has windows after it, 
# and then I reorder those windows with swap-window, there will be a gap in the 
# window numbering where the window I closed was.
# This is unacceptable.

if [ $# -ne 1 -o -z "$1" ]; then
    exit 1
fi

CURRENT_POS=$(tmux display-message -p '#I')

if [[ $1 == \+* ]]; then
	NEW_POS=$(expr $CURRENT_POS + `echo $1 | sed 's/^+//'`)
elif [[ $1 == \-* ]]; then
	NEW_POS=$(expr $CURRENT_POS - `echo $1 | sed 's/^-//'`)
else
	NEW_POS=$1
fi

# Ignore if the new position is less than zero.
if [ $NEW_POS -lt 0 ]; then
	exit 0
fi

if tmux list-windows | grep -q "^$NEW_POS:"; then
    tmux swap-window -t $NEW_POS
else
    tmux move-window -t $NEW_POS
fi

