################################################################################
#                                                                              #
#                                    Aliases                                   #
#                                                                              #
################################################################################

# generic 
alias ls='ls --color=auto -h'
alias ll='ls -l'
alias la='ls -la'
alias lt='ls -lt' # order by last modified date

alias ..='cd ..'
alias path='echo $PATH | tr ":" "\n"'

# programs
alias egrep='grep -Ern --color=auto --exclude-dir=".svn"'
alias t='todo'
alias c='clear'
alias screen='screen -U'
alias hist='history | grep $1'

# svn
alias svndiff="svn diff --diff-cmd diff -x -uwEB"

# git
alias g='git'
alias gs='git status'
alias gl='git log'
alias gd='git diff'

# ruby
alias r='rake'
alias rg='script/rails generate'
alias rs='script/rails server'
alias rc='script/rails console'
alias tl="tail -f log/development.log"

alias rfind='find . -name *.rb | xargs grep -n'

# bundler
alias b='bundle'
alias bx='bundle exec'
alias bi="bundle install"
alias bu="bundle update"


