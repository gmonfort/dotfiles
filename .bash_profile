[ -e ~/.bashrc ] && . ~/.bashrc

if [ -d ~/bin ]; then
    export PATH=~/bin:$PATH
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
