# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# don't allow for editing of history lines (backspace after Ctrl-r)
set revert-all-at-newline on

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# do really fancy stuff with history (keep it "forever")
## Sourced: https://twitter.com/michaelhoffman/status/639178145673932800
# this breaks CTRL-R
HISTFILE="${HOME}/.history/$(date -u +%Y/%m/%d/%H.%M.%S)_${HOSTNAME}_$$"
mkdir -p "${HISTFILE%/*}/"

# append to the history file, don't overwrite it. shouldn't be necessary.
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# if we don't have awk, enable fast path
[ -x /usr/bin/awk ] || FAST_PATH="yes"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi
# important variables to have set
export PATH="$HOME/bin:$PATH"
export BASE_PATH="$PATH"
export BASH_CONF="$HOME/.config/bash"

# umask, this is -rw------
umask 077

# shell prompt
if [ -f "$BASH_CONF/bash_ps1" ]; then
    source "$BASH_CONF/bash_ps1"
fi

# variables that are nice to have around
if [ -f "$BASH_CONF/bash_variables" ]; then
    source "$BASH_CONF/bash_variables"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "$BASH_CONF/bash_aliases" ]; then
    source "$BASH_CONF/bash_aliases"
fi

# extra bash completion stuff
if [ -f "$BASH_CONF/bash_completion" ]; then
    source "$BASH_CONF/bash_completion"
fi

