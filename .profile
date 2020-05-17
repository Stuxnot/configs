#!/bin/sh

#        __                       __ 
#   ___ / /___ ____ __ ___  ___  / /_
#  (_-</ __/ // /\ \ // _ \/ _ \/ __/
# /___/\__/\_,_//_\_\/_//_/\___/\__/ 
# https://github.com/stuxnot                                   

export EDITOR="nvim"
export VISUAL="nvim"

# Add bin to path
PATH=$PATH:/home/heartbleed/bin
export PATH

# Set monitor depending on hostname.
HOST=$(hostname)
if [[ $HOST -eq 'kronos' ]]; then
    export MONITOR=eDP1
elif [[ $HOST -eq 'hyperion' ]]; then
    export MONITOR=DisplayPort-0
    export SIDE_MONITOR=HDMI-0
fi
