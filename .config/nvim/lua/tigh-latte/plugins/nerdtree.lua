vim.pack.add {
	gh "PhilRunninger/nerdtree-visual-selection",
	gh "scrooloose/nerdtree",
}

vim.g.NERDTreeIgnore = { "\\.pyc$", "\\~$", "\\.swp$" }
vim.keymap.set("n", "<Leader>n", vim.cmd.NERDTreeToggle, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>f", vim.cmd.NERDTreeFind, { noremap = true, silent = true })
