#-------------------------------------------------
# ~/.bashrc
# vim:foldmethod=marker:nu:ai:si:et:ft=sh:
# -------------------------------------------------

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Options {{{1
#set -o vi                   # vi input mode
shopt -s autocd             # cd by naming directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
#shopt -s extglob            # enable extended pattern-matching features
shopt -s histappend         # append to (not overwrite) the history file
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive
# Variables {{{1
#export MYRUBYVER="ruby-2.1.5"
export NOSE_REDNOSE=1
export EDITOR=vim
export PAGER=vimpager
export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}
export MYGPGKEY=0xE8746802481AF0AE
# arch-wiki-lite
export wiki_browser="qutebrowser --backend webengine"
export BROWSER=links
if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
  [[ -f ~/.aws_keys ]] && . ~/.aws_keys
fi
[ -n "$DISPLAY" ] && export BROWSER="qutebrowser --backend webengine"

# Colors {{{2
#Reset
NONE='\[\e[0;0m\]'
# Regular Colors
# [color]B = Bold
# [color]I = Intense
# [color]BI = Bold, Intense
BLACK='\[\e[0;38m\]'
BLACKB='\[\e[1;38m\]'
BLACKBI='\[\e[1;98m\]'
BLACKI='\[\e[0;98m\]'
BLACKU='\[\e[4;38m\]'
RED='\[\e[0;31m\]'
REDB='\[\e[1;31m\]'
REDBI='\[\e[1;91m\]'
REDI='\[\e[0;91m\]'
REDU='\[\e[4;31m\]'
YELLOW='\[\e[0;33m\]'
YELLOWB='\[\e[1;33m\]'
YELLOWBI='\[\e[1;93m\]'
YELLOWI='\[\e[0;93m\]'
YELLOWU='\[\e[4;33m\]'
GREEN='\[\e[0;32m\]'
GREENB='\[\e[1;32m\]'
GREENBI='\[\e[1;92m\]'
GREENI='\[\e[0;92m\]'
GREENU='\[\e[4;32m\]'
BLUE='\[\e[0;34m\]'
BLUEB='\[\e[1;34m\]'
BLUEBI='\[\e[1;94m\]'
BLUEI='\[\e[0;94m\]'
BLUEU='\[\e[4;34m\]'
PURPLE='\[\e[0;35m\]'
PURPLEB='\[\e[1;35m\]'
PURPLEBI='\[\e[1;95m\]'
PURPLEI='\[\e[0;95m\]'
PURPLEU='\[\e[4;35m\]'
WHITE='\[\e[0;37m\]'
WHITEB='\[\e[1;37m\]'
WHITEBI='\[\e[1;97m\]'
WHITEI='\[\e[0;97m\]'
WHITEU='\[\e[4;37m\]'

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensty backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# Prompt {{{2
  # include hostname unless we're in a Tmux session
  PS1="\n$BLUE"
  #[ -z "$TMUX" ] && PS1+="\h$NONE:$BLUEI"
  PS1+="\w"
# {{{3 git completion
  # old method
if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
  export GIT_PS1_SHOWUPSTREAM="auto"
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWSTASHSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  PS1+=" $BLUE\$(__git_ps1 ' %s')$RED $NONE "
else
  # vcprompt method
  PS1+="$YELLOW\$(/usr/bin/vcprompt -f ' %n %b%m%u') "
fi
#PS1+="\n\$([ \$? -eq 0 ] && echo -e '$GREEN'|| echo -e '$RED')>$NONE "
PS1+="$NONE"
# Aliases {{{1
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
# Functions {{{1
# {{{2 Directory size
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm /tmp/list
}
# }}}2
# {{{2 Extract Files

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}
# }}}2
# {{{2 move/copy then follow
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
# }}}2
# {{{ Query wikipedia
wiki() { dig +short txt $1.wp.dg.cx; }
# }}}2
# {{{2 Nice mount output
nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }
# }}}2
# {{{2 Simple notes
n() { 
    mkdir ~/.notes 2> /dev/null 
    $EDITOR ~/.notes/"$*".txt 
}
nls() { ls -c ~/.notes | grep "$*" ;}
# }}}2
# {{{2 vim files
function vf() {
    vi `find ${1:-.} -type f | grep -v ".svn"`
}
# }}}2
# {{{2 colored man pages with less
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}
# }}}2
# {{{2 external IP
wmip() { printf "External IP: %s\n" $(curl -s http://ifconfig.me) ;}
# }}}2
# Bindings {{{1
#
# Source {{{1

if [ -f $HOME/.gpg-agent-info ]; then
  .  $HOME/.gpg-agent-info
  export GPG_AGENT_INFO
fi

if [[ -s $HOME/.local/bin/virtualenvwrapper.sh ]]; then
  . $HOME/.local/bin/virtualenvwrapper.sh
fi

[[ -s $HOME/bin/tmuxinator.bash ]] && . $HOME/bin/tmuxinator.bash

# command-not-found on Arch GNU/Linux
if [[ -r /usr/share/doc/pkgfile/command-not-found.bash ]]; then
  . /usr/share/doc/pkgfile/command-not-found.bash
fi

# }}}1

if [[ $TERM == "linux" ]]; then
  echo -en "\033]P0000000" # black
  echo -en "\033]P85e5e5e" # darkgray
  echo -en "\033]P18a2f58" # darkred
  echo -en "\033]P9cf4f88" # lightred
  echo -en "\033]P2287373" # darkgreen
  echo -en "\033]Pa53a6a6" # lightgreen
  echo -en "\033]P3914e89" # darkyellow
  echo -en "\033]Pbbf85cc" # lightyellow
  echo -en "\033]P4395573" # darkblue
  echo -en "\033]Pc4779b3" # lightblue
  echo -en "\033]P55e468c" # darkmagenta
  echo -en "\033]Pd7f62b3" # lightmagenta
  echo -en "\033]P62b7694" # darkcyan
  echo -en "\033]Pe47959e" # lightcyan
  echo -en "\033]P7899ca1" # lightgray
  echo -en "\033]Pfc0c0c0" # white
  clear                    # bring us back to default input colors
fi

eval "$(direnv hook bash 2> /dev/null)"
