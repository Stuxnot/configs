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

# Set monitor depending on hostname.
HOST=$(hostname)
if [[ $HOST = 'kronos' ]]; then
    export MONITOR=eDP1
elif [[ $HOST = 'hyperion' ]]; then
    export MONITOR=DisplayPort-0
    export SIDE_MONITOR=HDMI-A-0

    # Hack:
    # Set scale factor for alacritty, since it sometimes ignores the xrandr settings
    export WINIT_X11_SCALE_FACTOR=1.6
fi
