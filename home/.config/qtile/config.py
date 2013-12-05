# vim: set expandtab ts=4 sw=4 softtabstop=4:

from libqtile.command import lazy

import os
import os.path

mod = "mod4"
shift = "shift"
alt = "mod1"
ctrl = "control"



##########################
######## KEYBOARD ########
##########################

from libqtile.config import Key

keys = []

keys.append(Key([mod], "Escape", lazy.window.kill()))
keys.append(Key([alt], "F4", lazy.window.kill()))

# Grow / shrink for XMonad layout.
keys.append(Key([mod], "equal", lazy.layout.grow()))
keys.append(Key([mod], "minus", lazy.layout.shrink()))

# Old keyboard shortcut for Window switching.
keys.append(Key([mod],        "Tab", lazy.layout.up()))
keys.append(Key([mod, shift], "Tab", lazy.layout.down()))

# Maximize and normalize.
keys.append(Key([mod], "Return", lazy.layout.maximize()))
keys.append(Key([mod], "backslash", lazy.layout.normalize()))

# Shuffle windows through the stack.
stack_switch_keys = [
        # Super + the two keys on both sides of the top row of the keyboard to switch windows.
        ("bracketleft", "bracketright"),
        ("w", "e"),
]
for upkey, downkey in stack_switch_keys:
    keys.append(Key([mod], upkey, lazy.layout.up()))
    keys.append(Key([mod], downkey, lazy.layout.down()))
    for mod2 in [ctrl, alt, shift]:
        keys.append(Key([mod, mod2], upkey, lazy.layout.shuffle_up()))
        keys.append(Key([mod, mod2], downkey, lazy.layout.shuffle_down()))


# Switch between layouts.
layout_switch_keys = [
        # Super + the two keys on both sides of the bottom row of the keyboard to switch windows.
        ("period", "slash"),
        ("z", "x"),
]
for upkey, downkey in layout_switch_keys:
    keys.append(Key([mod], upkey, lazy.nextlayout()))
    keys.append(Key([mod], downkey, lazy.prevlayout()))


# Switch between screens.
screen_switch_keys = [
        # Super + the two keys on both sides of the middle row of the keyboard to switch windows.
        ("semicolon", "apostrophe"),
        ("s", "d"),
]

for firstkey, secondkey in screen_switch_keys:
    keys.append(Key([mod], firstkey, lazy.to_screen(0)))
    keys.append(Key([mod], secondkey, lazy.to_screen(1)))


keys.append(Key([mod, ctrl], "r", lazy.restart()))
keys.append(Key([mod, ctrl, shift, alt], "q", lazy.shutdown(),
            lazy.spawn("echo \"quit\" > /tmp/quitwait%s" % (os.environ["DISPLAY"].replace(":", "_")))))

keys.append(Key([mod, ctrl, alt, shift], "1", lazy.spawn(os.path.expanduser("~/.config/qtile/screenconf 1"))))
keys.append(Key([mod, ctrl, alt, shift], "2", lazy.spawn(os.path.expanduser("~/.config/qtile/screenconf 2"))))


#### Application Launching

# Slock for screen locking.
keys.append(Key([mod], "l", lazy.spawn("slock")))

# Synapse for doing stuff.
#keys.append(Key([mod], "space", lazy.spawn("synapse")))

# File browser
#keys.append(Key([mod], "e", lazy.spawn("nemo")))

# PulseAudio volume control
keys.append(Key([mod], "v", lazy.spawn("pavucontrol")))

# Terminal
keys.append(Key([ctrl, alt], "t", lazy.spawn("urxvt -e ~/.config/qtile/byobu-init")))



#######################
######## MOUSE ########
#######################

from libqtile.config import Click, Drag

mouse = []

mouse.append(Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()))
mouse.append(Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()))



#########################
######## GROUPS #########
#########################

from libqtile.config import Group, Match

group_web = Group("Web",
        layout="max",
        matches=[
            Match(wm_class=("chromium", "Chromium")),
            ]
        )

group_work = Group("Work",
        layout="monadtall",
        matches=[
            ]
        )

group_irc = Group("IRC",
        layout="treetab",
        matches=[
            Match(wm_class=("quasselclient", "Quasselclient")),
            Match(wm_class=("ts3client_linux_amd64", "Ts3client_linux_amd64")),
            ]
        )

group_other = Group("Other",
        matches=[
            ]
        )
groups = [group_web, group_work, group_irc, group_other]

from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder(mod)



#######################
######## RULES ########
#######################

from libqtile.config import Rule

dgroups_app_rules = [
    Rule(Match(wm_type=["dialog"]), float=True, intrusive=True),
]



#########################
######## LAYOUTS ########
#########################

from libqtile import layout

layouts = []
layouts.append(layout.MonadTall())
layouts.append(layout.Max())
layouts.append(layout.TreeTab())



###############################
######## BAR / WIDGETS ########
###############################

from libqtile import bar, widget

bar_font="Monospace"
bar_fontsize=13

widget_defaults = dict(
        font="Monospace",
        fontsize=13,
    )
# Custom group box widget.
from groupbox import GroupBox

def main_bar_widgets(screen_name):
    """
    Constructs a list of widgets for a main bar to show at the bottom of the screen.
    screen_name is either "main" or "secondary" and specifies which screen the bar is for.
    The layout of the bar may vary slightly depending on screen_name.
    """
    widgets = []
    widgets.append(GroupBox(margin_y=1, rounded=False, padding=2, highlight_method="block", urgent_text="FFFFFF"))
    widgets.append(widget.CurrentLayout())
    widgets.append(widget.Sep())
    widgets.append(widget.Prompt())
    widgets.append(widget.WindowName())
    widgets.append(widget.Sep())
    widgets.append(widget.Battery())
    widgets.append(widget.CPUGraph(graph_color="1313CC", fill_color="4242EB", border_color="1313CC", line_width=0, margin_y=2, border_width=1))
    widgets.append(widget.MemoryGraph(graph_color="13CC13", fill_color="42EB42", border_color="13CC13", line_width=0, margin_y=2, border_width=1))
    widgets.append(widget.Sep())
    if screen_name == "main": widgets.append(widget.Systray())
    widgets.append(widget.Sep())
    widgets.append(widget.Clock('%I:%M %p'))
    return widgets



#########################
######## SCREENS ########
#########################

from libqtile.config import Screen
from customscreen import CustomScreen

screens = []
main_screen = CustomScreen(bottom=bar.Bar(main_bar_widgets("main"), 24))
second_screen = CustomScreen(bottom=bar.Bar(main_bar_widgets("secondary"), 24))
screens = [main_screen, second_screen]



#########################
######## STARTUP ########
#########################

# Startup stuff.
import subprocess, re

def is_running(process):
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
    return False

def exec_cmd(cmd):
    return subprocess.Popen(cmd.split())

def exec_once(cmd):
    if not is_running(cmd):
        return subprocess.Popen(cmd.split())

from libqtile import hook
# start the applications at Qtile startup
@hook.subscribe.startup
def startup():
    exec_cmd("xsetroot -cursor_name left_ptr")
    exec_cmd("feh --bg-fill /usr/share/archlinux/wallpaper/archlinux-simplyblack.png")
    exec_once("compton -b --config .compton.conf")
    exec_once("synapse")
    exec_once("netmon")
    exec_once("dropboxd")



#######################
######## HACKS ########
#######################

# Hacks! Woo!
@hook.subscribe.client_managed
def client_managed(win):
    # Make sure Synapse's window is always on top.
    if win.match(wmclass="synapse"):
        win.qtile.log.info("Bringing Synapse window to front.")
        win.cmd_bring_to_front()
    elif win.window.get_wm_type() == "dialog" or win.window.get_wm_transient_for():
        # Center dialogs.
        wcenter = win.width//2
        hcenter = win.height//2
        screen = win.qtile.find_closest_screen(win.x, win.y)
        swcenter = screen.width//2
        shcenter = screen.height//2
        win.place(
                screen.x + (swcenter - wcenter),
                screen.y + (shcenter - hcenter),
                win.width, win.height,
                win.borderwidth, win.bordercolor)



#######################
######## OTHER ########
#######################

main = None
follow_mouse_focus = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True
