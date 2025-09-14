#!/usr/bin/env bash

__main() {
	wezterm cli set-window-title "$(tmux display -p '#{pane_current_command}')"
}

__main $@
