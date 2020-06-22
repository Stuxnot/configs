#        __                       __ 
#   ___ / /___ ____ __ ___  ___  / /_
#  (_-</ __/ // /\ \ // _ \/ _ \/ __/
# /___/\__/\_,_//_\_\/_//_/\___/\__/ 
# https://github.com/stuxnot                                   

###############################
#
# ### Table of Contents ###
#
# 1. General settings
# 2. Powerlevel10k
# 3. Zplug
#
###############################

###############################
#
# General settings
#
###############################

HISTFILE=$HOME/.config/zsh/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep
bindkey -v


# don't configure zsh if in virtual console.
if [[ $TERM != 'linux' ]]; then

    [[ ! -f ~/.config/zsh/aliases ]] || source $HOME/.config/zsh/aliases
    # Originally from:
    # https://stackoverflow.com/questions/20727730/dynamic-window-title-in-urxvt-with-zsh
    # works wonders with alacritty
    case $TERM in (*xterm* | rxvt | alacritty | Alacritty)
        # Write some info to terminal title.
        # This is seen when the shell prompts for input.
        function precmd {
            print -Pn "\e]0;zsh %(1j,%j job%(2j|s|); ,)%~\a"
        }
        # Write command and args to terminal title.
        # This is seen while the shell waits for a command to complete.
        function preexec {
            printf "\033]0;%s\a" "$1"
        }

      ;;
    esac

    # search history on up and down key
    bindkey '^[[A' history-beginning-search-backward
    bindkey '^[[B' history-beginning-search-forward

    export EDITOR="nvim"
    export VISUAL="nvim"

    ###############################
    #
    # Powerlevel10k
    #
    ###############################

    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # p10k is installed via pacman
    if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then  
        source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    fi

    [[ ! -f ~/.config/zsh/p10k.zsh ]] || source $HOME/.config/zsh/p10k.zsh


    ###############################
    #
    # Zplug
    #
    ###############################

    export ZPLUG_HOME=$HOME/.config/zsh/zplug
    source $ZPLUG_HOME/init.zsh

    # oh-my-zsh plugins
    zplug "plugins/git",                        from:oh-my-zsh
    zplug "plugins/command-not-found",          from:oh-my-zsh
    zplug "plugins/adb",                        from:oh-my-zsh
    zplug "plugins/common-aliases",             from:oh-my-zsh

    # Plugins
    zplug "b4b4r07/enhancd",                    use:init.sh
    zplug "zsh-users/zsh-syntax-highlighting",  defer:2
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-autosuggestions"

    zplug load 

    # plugin config zsh-autosuggestions
    # autocompletions on <c-n>
    bindkey '^N' autosuggest-accept
else
    export EDITOR="vi"
fi
