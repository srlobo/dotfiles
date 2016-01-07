# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	if [ -z "${BASH_COMPLETION}" ]
	then
		. /etc/bash_completion
	fi
fi

if [ -f $HOME/.bash_completion ]
then
	. $HOME/.bash_completion
fi

unset LANG LC_ALL LC_MESSAGES
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
unset LANGUAGE

export DEBEMAIL="debemail@debemail"
export DEBFULLNAME="debfulname"
export UNSIGN_SOURCE

export EDITOR="vim"

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
