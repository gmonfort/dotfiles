################################################################################
#                                                                              #
#                                    Aliases                                   #
#                                                                              #
################################################################################

# generic

if [[ "$OSTYPE" =~ "linux" ]]; then
  alias ls='ls --color=auto -h'
else
  alias ls='ls -Gh'
fi

alias ll='ls -l'
alias la='ls -la'
alias lt='ls -lt' # order by last modified date

alias ..='cd ..'
alias path='echo $PATH | tr ":" "\n"'

# programs
alias egrep='grep -Ern --color=auto'
alias t='todo'
alias c='clear'
alias screen='screen -U'
alias hist='history | grep $1'

# svn
alias svndiff="svn diff --diff-cmd diff -x -uwEB"

# git
alias g='git'
alias gs='git status'
alias gf='git fetch'
alias ga='git add'
alias gc='git commit'
alias gl='git log'
alias gd='git diff'
alias gdc='git diff --cached'
alias grc='git rebase --continue'

# ruby
alias r='rake'
alias rg='script/rails generate'
alias rs='script/rails server'
alias rc='script/rails console'
alias tl="tail -f log/development.log"

alias rfind='find . -name *.rb | xargs grep -n'
alias z='zeus'

# bundler
alias b='bundle'
alias bx='bundle exec'
alias bi="bundle install"
alias bu="bundle update"

# other
alias fs='foreman start'
alias fr='foreman run'
