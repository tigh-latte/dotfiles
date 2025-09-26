#!/bin/sh


__main() {
	local session="_popup_music_player"

	local current_session=$(tmux display-message -p '#S')

	if [ "$current_session" = "$session" ]; then
		tmux detach
		return
	fi

	if ! tmux has -t "$session" 2> /dev/null; then
		session_id=$(tmux new-session -dP -s "$session" -F '#{session_id}')
		tmux set-option -s -t "$session_id" key-table popup
		tmux set-option -s -t "$session_id" status off
		tmux send-keys -t "$session" 'hifi-rs open' C-m
	fi

	tmux attach -t "$session" > /dev/null
}

__main
