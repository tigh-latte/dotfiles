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
		ln -s ${PWD}/${file} ${HOME}/${file}
	done

	## install .config content.
	for file in *; do
		[ ! -d "${file}" ] && continue

		ln -s ${PWD}/${file} ${HOME}/.config/${file}
	done
}

main
