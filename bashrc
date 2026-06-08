# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# Prevent doublesourcing
if [ -z "$BASHRCSOURCED" ]; then
  BASHRCSOURCED="Y"

  # are we an interactive shell?
  if [ "$PS1" ]; then
    if [ -z "$PROMPT_COMMAND" ]; then
      declare -a PROMPT_COMMAND
      case $TERM in
      xterm*)
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      screen*)
        if [ -e /etc/sysconfig/bash-prompt-screen ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
        else
            PROMPT_COMMAND='printf "\033k%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      *)
        [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
        ;;
      esac
    fi
    # Turn on parallel history
    shopt -s histappend
    # Turn on checkwinsize
    shopt -s checkwinsize
    # Change the default prompt string
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
    # You might want to have e.g. tty in prompt (e.g. more virtual machines)
    # and console windows
    # If you want to do so, just add e.g.
    # if [ "$PS1" ]; then
    #   PS1="[\u@\h:\l \W]\\$ "
    # fi
    # to your custom modification shell script in /etc/profile.d/ directory
  fi

  if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it gets undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

    # Set default umask for non-login shell only if it is set to 0
    [ `umask` -eq 0 ] && umask 022

    SHELL=/bin/bash
    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null
            fi
        fi
    done

    unset i
    unset -f pathmunge
  fi

fi
# vim:ts=4:sw=4
clear;fastfetch -l Aperture  --pipe false
PROMPT_COMMAND='PS1_CMD1=$(id -Z); PS1_CMD2=$(id -u); PS1_CMD3=$(ip route get 1.1.1.1 | awk -F"src " '"'"'NR == 1{ split($2, a," ");print a[1]}'"'"'); PS1_CMD4=$(pwd)'; PS1='\[\e[91m\][\[\e[93m\]${PS1_CMD1}\[\e[91m\]]\[\e[0m\] \[\e[35m\]\u\[\e[0m\]:\[\e[95m\]${PS1_CMD2}\[\e[0m\]@\[\e[96m\]\h\[\e[0m\]:\[\e[96m\]${PS1_CMD3}\[\e[0m\](\[\e[92m\]${PS1_CMD4}\[\e[0m\])\n\[\e[94m\]#\[\e[93m\]\T\[\e[91m\]>\[\e[0m\] '
