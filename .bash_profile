[ -e ~/.bashrc ] && . ~/.bashrc

if [ -d ~/bin ]; then
  PATH=$PATH:~/bin
fi

if [ -d /usr/local/git/bin ]; then
  PATH="/usr/local/git/bin:$PATH"
fi

export $PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
