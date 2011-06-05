#!/bin/sh

HOME="~"
if [ ! -z "$1" ]; then
    HOME="$1"
fi 

DOTFILES_REPO="git://github.com/gmonfort/dotfiles.git"

cd $HOME
if [ ! -d "$HOME/code" ]; then
    mkdir "$HOME/code"
    cd $HOME/code
fi

git clone $DOTFILES_REPO
cd dotfiles

# make symlinks to $HOME
# ensure we're on the base of the dotfiles repo
toplevel="$(git rev-parse --show-toplevel)" || echo "Not in git directory" && exit

cd "$toplevel" && for f in $(ls -A); do
  [ $f = .git ] && continue
  [ -f $HOME/$f || -L $HOME/$f ] && mv $HOME/"$f"{,.bak}
  ln -s "$toplevel/$f" $HOME/"$f"
done

# RVM
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

exit 0
