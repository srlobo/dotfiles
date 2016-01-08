# vi:syntax=sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# MacOSX con macports
if [ /opt/local/bin/bash == $BASH ]
then
	source /opt/local/etc/bash_completion
fi


unset LANG LC_ALL LC_MESSAGES
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
unset LANGUAGE
export EDITOR="vim"

## Prompt
ResetColours="$(tput sgr0)"
Black="$(tput setaf 0)"
BlackBG="$(tput setab 0)"
DarkGrey="$(tput bold ; tput setaf 0)"
LightGrey="$(tput setaf 7)"
LightGreyBG="$(tput setab 7)"
White="$(tput bold ; tput setaf 7)"

Red="$(tput setaf 1)"
RedBG="$(tput setab 1)"
LightRed="$(tput bold ; tput setaf 1)"
Green="$(tput setaf 2)"
GreenBG="$(tput setab 2)"
LightGreen="$(tput bold ; tput setaf 2)"
Brown="$(tput setaf 3)"
BrownBG="$(tput setab 3)"
Yellow="$(tput bold ; tput setaf 3)"
Blue="$(tput setaf 4)"
BlueBG="$(tput setab 4)"
BrightBlue="$(tput bold ; tput setaf 4)"
Purple="$(tput setaf 5)"
PurpleBG="$(tput setab 5)"
Pink="$(tput bold ; tput setaf 5)"
Cyan="$(tput setaf 6)"
CyanBG="$(tput setab 6)"
BrightCyan="$(tput bold ; tput setaf 6)"


if [ "$PS1" ]; then
  if [ "$BASH" ]; then
    #PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '
	PS1='\u@\h:\w\$ '


  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

export PATH

umask 022

pideusu()
{
	usuario="$1"

	if [ -z "$usuario" ]
	then
		if echo "$USER" | egrep -q '[aA][0-9]{6}'
		then
			usuario="$USER"
		else
			read -p "Usuario:" usuario
		fi
	fi

	read -sp "Contrasena del usuario $usuario:" contrasena
	echo ""

	if echo $contrasena | kinit $usuario > /dev/null 2>&1
	then
		export http_proxy=http://${usuario}:${contrasena}@proxy.cm.es:8080/
		export https_proxy=http://${usuario}:${contrasena}@proxy.cm.es:8080/
		export ftp_proxy=http://${usuario}:${contrasena}@proxy.cm.es:8080/
		export no_proxy=slipt01,slipt001,slipt001.cm.es,aqdes-stash.cm.es,aqdes-stash
	else
		echo "Usuario o contrasena incorrecta!"
	fi
}

for i in /etc/profile.d/*.sh ; do
    if [ -r "$i" ]; then
        . $i
    fi
done
unset i


for a in /etc/bash_completion.d/*
do
	source $a
done
source .git-flow-completion.bash

source /usr/bin/virtualenvwrapper.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export VIRTUAL_ENV_DISABLE_PROMPT=1

function prompt_command
{
    e_STATUS=$?
    if [ $e_STATUS -ne 0 ]
    then
        e_STATUS="${Blue}[${Yellow}Exit Status ${e_STATUS}${Blue}]${ResetColours}"
        echo $e_STATUS
    fi

	status_line=""

	g_status=$(__git_ps1 "git:$Green(%s)$ResetColours ")
	status_line=${status_line}${g_status}


	ve_status=""
	if [ -n "$VIRTUAL_ENV" ]
	then
		ve_status="ve:($Green"$(basename "$VIRTUAL_ENV")"$ResetColours) "
	fi
	status_line=${status_line}${ve_status}

	proxy_status=""
	if [ -n "$http_proxy" ]
	then
		proxy_user=$(echo $http_proxy | sed -e 's,^http://,,' -e 's,:.*$,,')
		proxy_status="proxy:(${Green}$proxy_user$ResetColours) "
	fi
	status_line=${status_line}${proxy_status}

	if [ -n "$status_line" ]
	then
		echo $status_line
	fi
}
PROMPT_COMMAND=prompt_command

source /aplicaciones/oracle/oradcli01/admin/entorno/entorno_oradcli01.sh

export NVM_DIR="/datos/usuarios/A142257/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#[[ $- = *i* ]] && source ~/dotfiles/liquidprompt/liquidprompt
