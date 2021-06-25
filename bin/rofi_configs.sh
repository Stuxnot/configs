#!/bin/bash
#   __           ___     __   __
#  / /____  ___ <  /__ _/ /  / /_
# / __/ _ \/ _ \/ / _ `/ _ \/ __/
# \__/\___/_//_/_/\_, /_//_/\__/
#                /___/
# https://github.com/ton1ght


declare options=("alacritty
bspwm
sxhkd
dunst
ranger
nvim
polybar
rofi
xresources
zsh
aliases
profile
quit")

choice=$(echo -e "${options[@]}" | rofi -dmenu  -i -p 'Edit config file')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
        file="$HOME/.config/alacritty/alacritty.yml"
	;;
	bspwm)
        file="$HOME/.config/bspwm/bspwmrc"
	;;
	sxhkd)
        file="$HOME/.config/sxhkd/sxhkdrc"
	;;
	rofi)
        file="$HOME/.config/rofi/config.rasi"
	;;
	dunst)
        file="$HOME/.config/dunst/dunstrc"
	;;
	ranger)
        file="$HOME/.config/ranger/rc.conf"
	;;
	nvim)
        file="$HOME/.config/nvim/init.vim"
	;;
	polybar)
        file="$HOME/.config/polybar/config"
	;;
	xresources)
        file="$HOME/.Xresources"
	;;
	zsh)
        file="$HOME/.zshrc"
	;;
    aliases)
        file="$HOME/.config/zsh/aliases"
    ;;
    profile)
        file="$HOME/.profile"
    ;;
	*)
		exit 1
	;;
esac

alacritty -t "vim $choice" -e nvim "$file"
