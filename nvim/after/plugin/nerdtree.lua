vim.g.NERDTreeIgnore = {"\\.pyc$", "\\~$", "\\.swp$"}
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>f', ':NERDTreeFind<CR>', { noremap = true, silent = true})
