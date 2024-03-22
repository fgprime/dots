#!/bin/bash
# Script to initialize tmuxinator with worktree project
if [[ $TERM =~ ^screen.* ]]; then
	if [ -n "$(git -C "$directory" rev-parse --git-dir 2>/dev/null)" ]; then
		if [[ -z "$1" ]]; then
			git worktree list --porcelain | grep worktree | sed 1d | awk -F.git/ '{print $2}' | fzf-tmux -p | xargs tmuxinator start PRJ
		else
			tmuxinator start PRJ $1
		fi
	else
		echo "The directory is not a Git repository."
	fi
else
	exec tmux
fi
