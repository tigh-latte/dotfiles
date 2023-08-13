require("tigh-latte.lazy")

vim.g.mapleader = "\\"

-- Basic text editor
vim.o.background="light"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.number = true
vim.o.encoding = "utf-8"

vim.o.ai = true
vim.o.si = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.nu = true

-- Window management
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true, silent = true})

-- Terminal management
vim.api.nvim_set_keymap('n', '<Leader>z', ':vsplit term://zsh<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':split term://zsh<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('t', '<C-N>', '<C-\\><C-N>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-H>', '<C-\\><C-N><C-W><C-H>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-J>', '<C-\\><C-J>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-K>', '<C-\\><C-K>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-L>', '<C-\\><C-L>', { noremap = true })

vim.cmd([[
    augroup TerminalHelpers
        autocmd!
        autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
        autocmd TermOpen * setlocal nonumber
        autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
    augroup END
]])

-- Indentation
vim.api.nvim_set_keymap('n', '<Leader>,', '>i}', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>.', '<i}', { noremap = true })


-- Vim Specific
vim.o.list = true
vim.o.listchars="tab:· ,extends:›,precedes:‹,nbsp:·,trail:·"
vim.g.swapfile = true

vim.opt["guicursor"] = ""
