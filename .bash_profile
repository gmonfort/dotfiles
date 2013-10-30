[ -e ~/.bashrc ] && . ~/.bashrc

if [ -d ~/bin ]; then
  PATH=$PATH:~/bin
fi

if [ -d /usr/local/git/bin ]; then
  PATH="/usr/local/git/bin:$PATH"
fi

if [ -d /usr/local/bin ]; then
  PATH="/usr/local/bin:$PATH"
fi

export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# complete -o default -o nospace -W “$(grep “^Host” $HOME/.ssh/config | cut -d” ” -f2)” scp sftp ssh

complete -o default -o nospace -W "$(grep "^Host" $HOME/.ssh/config | cut -d" " -f2)" scp sftp ssh
