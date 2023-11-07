#!/bin/bash

__IGNORE_FILES=(
	.
	..
	.git
	.gitignore
)

main() {
	## if .config doesn't exist, create it.
	[ ! -d "${HOME}/.config" ] && mkdir ${HOME}/.config

	## install home level content
	for file in .*; do
		[[ " ${__IGNORE_FILES[*]} " =~ " ${file} " ]] && continue

		local config_dest=${HOME}/${file}

		# Config file exists and is a symlink
		([ -f "$config_dest" ] && [ -L "$config_dest" ]) && {
			echo "skipping, already installed: ${config_dest}"
			continue
		}
		# Config file exists but not as a symlink (hasn't been installed via this script)
		([ -f "$config_dest" ] && [ ! -L "$config_dest" ]) && {
			echo "${config_dest} exists on machine. Performing backup and removal."
			mv ${config_dest} ${config_dest}.tigh-latte.bkp
		}

		# install config.
		ln -s ${PWD}/${file} ${HOME}/${file}
	done

	## install .config content.
	for file in *; do
		[ ! -d "${file}" ] && continue

		local config_dest=${HOME}/.config/${file}

		# Config dir exists and is a symlink
		([ -d "$config_dest" ] && [ -L "$config_dest" ]) && {
			echo "skipping, already installed: ${config_dest}"
			continue
		}
		# Config dir exists but not as a symlink (hasn't been installed via this script)
		([ -d "$config_dest" ] && [ ! -L "$config_dest" ]) && {
			echo "${config_dest} exists on machine. Performing backup and removal."
			mv ${config_dest} ${config_dest}.tigh-latte.bkp
		}

		# install config.
		ln -s ${PWD}/${file} ${HOME}/.config/${file}
	done
}

main
