#!/bin/bash

[[ -z "$BACKUP_FILES" ]] && BACKUP_FILES=1

if [ ! -z "$1" ]; then
    HOME="$1"
fi 

echo "Using HOME: $HOME"
echo "BACKUP_FILES: $BACKUP_FILES"

# make symlinks to $HOME
# ensure we're on the base of the dotfiles repo
toplevel="$(git rev-parse --show-toplevel)" || (echo "Not in git directory" && exit 1)

echo "symlinking ..."
cd "$toplevel" && for f in $(ls -A); do
    [[ $f = .git ]] && continue
    [[ $f =~ ^[^.] ]] && continue # only dot files
    if [[ -f $HOME/$f || -L $HOME/$f ]]; then
        if [ ! -z "$BACKUP_FILES" ]; then
            mv $HOME/"$f"{,.bak}
        else
            rm -f "$HOME/$f"
        fi
    fi
    echo "Symlinking $toplevel/$f to $HOME/$f ..."
    ln -s "$toplevel/$f" $HOME/"$f"
done

exit 0
