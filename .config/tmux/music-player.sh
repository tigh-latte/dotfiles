#!/bin/sh

session="_popup_music_player"

if ! tmux has -t "$session" 2> /dev/null; then
	session_id=$(tmux new-session -dP -s "$session" -F '#{session_id}')
	tmux set-option -s -t "$session_id" key-table popup
	tmux set-option -s -t "$session_id" status off
	tmux set-option -s -t "$session_id" prefix None
	tmux send-keys -t "$session" 'hifi-rs open' C-m
fi

tmux attach -t "$session" > /dev/null
