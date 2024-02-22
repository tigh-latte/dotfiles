vim.g.NERDTreeIgnore = { "\\.pyc$", "\\~$", "\\.swp$" }
vim.g.NERDTreeGitStatusShowIgnored = 1
vim.g.NERDTreeGitStatusConcealBrackets = 1
vim.api.nvim_set_keymap("n", "<Leader>n", ":NERDTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>f", ":NERDTreeFind<CR>", { noremap = true, silent = true })

vim.cmd([[
    let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Ignored'     : '!',
      \ }
]])
