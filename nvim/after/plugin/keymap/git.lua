vim.keymap.set('n', '<Leader>gst', ':Git status<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>gbb', ':Git blame<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>git", vim.cmd.Git)
