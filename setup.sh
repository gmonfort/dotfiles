#!/bin/bash

BACKUP_FILES=
HOME=$(readlink -fn ~)
if [ ! -z "$1" ]; then
    HOME="$1"
fi 
echo "Using HOME: $HOME"

# make symlinks to $HOME
# ensure we're on the base of the dotfiles repo
toplevel="$(git rev-parse --show-toplevel)" || (echo "Not in git directory" && exit 1)

echo "symlinking ..."
cd "$toplevel" && for f in $(ls -A); do
    [[ $f = .git ]] && continue
    [[ $f =~ ^[^.] ]] && continue # only dot files
    if [[ (-f $HOME/$f || -L $HOME/$f) && $BACKUP_FILES ]]; then
        mv $HOME/"$f"{,.bak}
    fi
    ln -s "$toplevel/$f" $HOME/"$f"
done

# RVM
# bash < <( curl https://rvm.beginrescueend.com/install/rvm )

exit 0
