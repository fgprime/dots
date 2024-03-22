#!/usr/bin/env bash
# Copy from 
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-cht.sh

selected=`cat ~/.scripts/.tmux-cht-languages ~/.scripts/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.scripts/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    # tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl https://cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl -s https://cht.sh/$selected/$query | ansifilter | less"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | ansifilter | less"
fi
