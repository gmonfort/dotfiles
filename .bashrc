# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# bind -x '"\C-k": printf "\ec"';
# bind -x '"^K": printf "\ec"';
# bind -x '"^K": clear && printf "\e[3J"';
# bind -x '"^K": clear && printf "\ec" && printf "^M"';

if [ "$(type -t __git_ps1)" = "function" ]; then
  git_branch=$(__git_ps1)
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_variables ]; then
  . ~/.bash_variables
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

if [ -f /usr/lib/git-core/git-sh-prompt ]; then
  . /usr/lib/git-core/git-sh-prompt
fi

complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh

if [[ "$OSTYPE" =~ "linux" ]]; then
  xhost +LOCAL: 1>/dev/null 2>/dev/null
fi

[ -d ~/bin ] && export PATH="$PATH:~/bin"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
PATH=/usr/lib/postgresql/9.6/bin:$PATH
PATH=~/.local/bin:$PATH
PATH="$HOME/.rbenv/bin:$PATH"
export PATH

eval "$(rbenv init -)"
# eval "$(direnv hook bash)"
