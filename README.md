# muh dutfiles

Time to join the not-so-special group of folks with their dotfiles on github (even though these repos usually don't hold dotfiles, and instead have dirs in `${XDG_CONFIG_HOME})`.

## Structure

So, the root of the repo contains files that will be installed to `${HOME}`, ignoring the normal `.git`, `.gitignore`, etc etc, and will be installed via symlink to `${HOME}/<name>`.

All directories are assumed to live under `${XDG_CONFIG_HOME}`, and therefore will be installed via symlink to `${XDG_CONFIG_HOME}/.config/<name>`

## Should I use this?

Probably not, it's a meh alacritty setup, a basic tmux config that only allows ones session, and golang-only neovim.
