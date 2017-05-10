case $- in
  *i*) ;;
  *) return;;
esac

###########################
#  Environment Variables  #
###########################
export GEM_HOME="$(/usr/bin/ruby -e 'print Gem.user_dir')"
export GPG_TTY="$(tty)"

PATH="~/.local/bin:$PATH"
PATH+=":$GEM_HOME/bin"
PATH+=":$(/usr/bin/python -c 'import site; print(site.getuserbase())')/bin"
PATH+=":$(/usr/bin/python3 -c 'import site; print(site.getuserbase())')/bin"
PATH+=":$GOPATH/bin"
export PATH

###########################
#  Aliases and Functions  #
###########################
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias peda='GDB_USE_PEDA=1 GDB_USE_PWNDBG=0 gdb'
alias pwndbg='GDB_USE_PEDA=0 GDB_USE_PWNDBG=1 gdb'
alias xmonad-replace='nohup xmonad --replace &> /dev/null &'

#############
#  History  #
#############
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s cmdhist
shopt -s lithist
shopt -s histappend

##########
#  Misc  #
##########
shopt -s checkjobs
shopt -s checkwinsize
shopt -s globstar

command -v lesspipe >/dev/null 2>&1 && eval "$(SHELL=/bin/sh lesspipe)"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$HOME/bin:$PATH

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME=$HOME/.virtualenvs
	source /usr/local/bin/virtualenvwrapper.sh
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
