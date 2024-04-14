-- Return a function which will open a zsh terminal using the provided
-- function. Intended to be used with a keybinding for splitting
-- horizontal or vertical.
--- @param fn function
--- @return function
local function build_term(fn)
	return function()
		fn("term://zsh")
	end
end

vim.keymap.set("n", "<Leader>z", build_term(vim.cmd.vsplit), { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>v", build_term(vim.cmd.vsplit), { noremap = true, silent = true })

vim.keymap.set("n", "<Leader><Leader>", build_term(vim.cmd.split), { noremap = true, silent = true })

-- Window navigation while in a terminal buffer made much, much easier.
vim.api.nvim_set_keymap("t", "<C-N>", "<C-\\><C-N>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-H>", "<C-\\><C-N><C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-J>", "<C-\\><C-N><C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-K>", "<C-\\><C-N><C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-L>", "<C-\\><C-L>", { noremap = true })

-- Enter insert mode upon entering terminal buffer
vim.cmd([[
    augroup TerminalHelpers
        autocmd!
        autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
        autocmd TermOpen * setlocal nonumber
        autocmd TermOpen * setlocal norelativenumber
        autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
    augroup END
]])
