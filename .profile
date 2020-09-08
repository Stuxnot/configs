#!/bin/sh

#        __                       __ 
#   ___ / /___ ____ __ ___  ___  / /_
#  (_-</ __/ // /\ \ // _ \/ _ \/ __/
# /___/\__/\_,_//_\_\/_//_/\___/\__/ 
# https://github.com/stuxnot                                   

# export EDITOR
# will be overwritten by zsh if in
# virtual console
export EDITOR="nvim"
export VISUAL="nvim"


# Add bin to path
PATH=$PATH:/home/heartbleed/bin
export PATH

eval $(ssh-agent)

# configure qt to use correct theme settings
[ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"

# Set monitor depending on hostname.
HOST=$(hostname)
if [[ $HOST = 'kronos' ]]; then
    connectedSecondary=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | awk 'NR==2')
    export MONITOR=eDP1
    if [[ ! -z "$connectedSecondary" ]]; then
        export MONITOR="$connectedSecondary"
        xrandr --output eDP1 --off --output $connectedSecondary --primary 
        export WINIT_X11_SCALE_FACTOR=1.6
    fi
elif [[ $HOST = 'hyperion' ]]; then
    export MONITOR=DisplayPort-0
    export SIDE_MONITOR=HDMI-A-0

fi
# Hack:
# Set scale factor for alacritty, since it sometimes ignores the xrandr settings
export WINIT_X11_SCALE_FACTOR=1.6
