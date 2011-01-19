#!/bin/bash

# ensure we're on the base of the dotfiles repo
toplevel="$(git rev-parse --show-toplevel)" || exit

cd "$toplevel" && for f in .[!.]*; do
  [[ $f = .git ]] && continue
  [[ -e ~/$f ]] && mv ~/"$f"{,.bak}
  ln -s "$toplevel/$f" ~/"$f"
done
