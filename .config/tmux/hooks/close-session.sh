#!/bin/sh

__main() {
	local num_sessions=$(tmux list-sessions | wc -l)
	if [ "$num_sessions" -eq 1 ]; then
		local session=$(tmux display-message -p '#S')
		if [ "$session" = "_popup_music_player" ]; then
			tmux kill-session -t "$session"
		fi
	fi
}

# __main
