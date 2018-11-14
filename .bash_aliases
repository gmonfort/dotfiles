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
alias egrep="grep -Ern --color=auto --exclude-dir=\*.{git,bundle} --exclude-dir=node_modules --exclude-dir=log --exclude-dir='./lib/assets/dist' --exclude-dir='./lib/assets/public'"
alias t="todo -f '+children'"
alias c='clear'
alias screen='screen -U'
alias hist='history | grep $1'

# git
alias gs='git status'
alias gf='git fetch'
alias ga='git add'
alias gc='git commit'
alias gl='git log'
alias gd='git diff'
alias gdc='git diff --cached'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gb='git branch'

alias tl="tail -f log/development.log"

alias rfind='find . -name *.rb | xargs grep -n'
alias z='zeus'

# bundler
alias bx='bundle exec'
alias bi="bundle install"
alias bu="bundle update"

# foreman
alias fr='foreman run'
