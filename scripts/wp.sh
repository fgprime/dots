#!/bin/bash
# Script to initialize tmuxinator with worktree project
if [[ $TERM =~ ^screen.* ]]; then
	if [[ -z "$1" ]]; then
		fd --type d | fzf-tmux -p | xargs tmuxinator start PRJ
	else
		tmuxinator start PRJ $1
	fi
else
	exec tmux
fi
