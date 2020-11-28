#!/usr/bin/env sh

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(cat /etc/hostname) = 'hyperion' ]]; then
    exec polybar --reload desktop &
elif [[ $(cat /etc/hostname) = 'kronos' ]]; then
    exec polybar --reload laptop &
else
    exec polybar --reload main &
fi

if [[ ! -z $SIDE_MONITOR ]]; then
    exec polybar --reload side &
fi
