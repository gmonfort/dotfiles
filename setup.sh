#!/bin/bash

# homebrew
ruby -e "$(curl -fsSL https://gist.github.com/raw/323731/install_homebrew.rb)"
brew install git
brew install synergy
brew install tmux
brew install macvim
brew install mysql
brew install postgresql
brew install sqlite
brew install bash-completion

# postgres
initdb `brew --prefix`/var/postgres
cp `brew --prefix postgresql`/org.postgresql.postgres.plist
~/Library/LaunchAgents
launchctl load -w ~/Library/LaunchAgents/org.postgresql.postgres.plist

# mysql
unset TMPDIR
mysql_install_db
cp `brew --prefix`/com.mysql.mysqld.plist ~/Library/LaunchAgents
launchctl load -w ~/Library/LaunchAgents/com.mysql.mysqld.plist

# rvm
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm install 1.9.2
rvm install ree
rvm use 1.9.2 --default

#Some gems
#Hitch
gem i hitch
#Vagrant
gem i vagrant

#Bundlers
gem i bundler isolate

exec symlink_dotfiles.sh
