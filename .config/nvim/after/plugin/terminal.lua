vim.keymap.set("n", "<Leader>z", function()
	vim.cmd.vsplit("term://zsh")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader><Leader>", function()
	vim.cmd.split("term://zsh")
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<C-N>", "<C-\\><C-N>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-H>", "<C-\\><C-N><C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-J>", "<C-\\><C-N><C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-K>", "<C-\\><C-N><C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-L>", "<C-\\><C-L>", { noremap = true })

vim.cmd([[
    augroup TerminalHelpers
        autocmd!
        autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
        autocmd TermOpen * setlocal nonumber
        autocmd TermOpen * setlocal norelativenumber
        autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
    augroup END
]])
