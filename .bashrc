export PATH=$HOME/bin:/usr/local/bin:$PATH

# We're using 64 bits, right?
export ARCHFLAGS="-arch x86_64"

# Editor
export EDITOR=vim
export VISUAL=$EDITOR

# Global path for cd (no matter which directory you're in right now)
export CDPATH=.:~:~/code

# Ignore from history repeat commands, and some other unimportant ones
export HISTIGNORE="&:[bf]g:c:exit"

# Ruby development made easier
export RUBYOPT="rubygems Ilib Itest Ispec"

# Use vim to browse man pages. One can use Ctrl-[ and Ctrl-t
# to browse and return from referenced man pages. ZZ or q to quit.
# NOTE: initially within vim, one can goto the man page for the
#       word under the cursor by using [section_number]K.
export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" \
-c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

################################################################################
#                                                                              #
#                               External Scripts                               #
#                                                                              #
################################################################################

# Ruby Version Manager
if [[ -s ~/.rvm/scripts/rvm ]]; then
  . ~/.rvm/scripts/rvm;
fi

# Bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
  . `brew --prefix`/Library/Contributions/brew_bash_completion.sh
fi

# Hitch
hitch() {
  command hitch "$@"

  if [[ -s "$HOME/.hitch_export_authors" ]]; then
    . "$HOME/.hitch_export_authors";
  fi
}; hitch
alias unhitch='hitch -u'

################################################################################
#                                                                              #
#                                    Aliases                                   #
#                                                                              #
################################################################################

# General
alias ll='ls -la'
alias ls='ls -G'
alias c='clear'
alias g='git'
alias gs='git status'
alias gl='git log'
alias ..='cd ..'
alias screen='screen -U'
alias retag='ctags --extra=+f -R .'
alias start_postgres='postgres -D /usr/local/var/postgres -r /usr/local/var/postgres/server.log'

# Ruby
alias r='rake'

# Rails 2
alias sg='script/generate'
alias ss='script/server'
alias sc='script/console'
alias sd='script/dbconsole'

# Rails 3
alias rg='script/rails generate'
alias rs='script/rails server'
alias rc='script/rails console'
alias rd='script/rails dbconsole'

# Bundler
alias b='bundle'
alias bx='bundle exec'

################################################################################
#                                                                              #
#                                   Functions                                  #
#                                                                              #
################################################################################

# cd into matching gem directory
cdgem() {
  local gempath=$(gem env gemdir)/gems
  if [[ $1 == "" ]]; then
    cd $gempath
    return
  fi

  local gem=$(ls $gempath | g $1 | sort | tail -1)
  if [[ $gem != "" ]]; then
    cd $gempath/$gem
  fi
}
_cdgem() {
  COMPREPLY=($(compgen -W '$(ls `gem env gemdir`/gems)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0;
}
complete -o default -o nospace -F _cdgem cdgem;

# Encode the string into "%xx"
urlencode() {
  ruby -e 'puts ARGV[0].split(/%/).map{|c|"%c"%c.to_i(16)} * ""' $1
}

# Decode a urlencoded string ("%xx")
urldecode() {
  ruby -r cgi -e 'puts CGI.unescape ARGV[0]' $1
}

# Use MacVim's terminal vim (requires MacVim installed via homebrew)
vim() {
  local macvim_path=$(brew info macvim | sed -n '/installed to:/ {n;p;q;}')/MacVim.app/Contents/MacOS/Vim
  if [[ -x $macvim_path ]]; then
    "$macvim_path" "$@"
  else
    command vim "$@"
  fi
}

ackvim(){
  local pattern=$1; shift
  ack -l --print0 "$pattern" "$@" | xargs mvim -0o +/"$pattern"
}

################################################################################
#                                                                              #
#                                     Prompt                                   #
#                                                                              #
################################################################################

# Prompt in two lines:
#   <hostname> <full path to pwd> (git: <git branch>)
#   ▸
export PS1='\[\033[01;32m\]\h \[\033[01;33m\]\w$(__git_ps1 " \[\033[01;36m\]\
(git: %s)")\[\033[01;37m\]\n▸\[\033[00m\] '
