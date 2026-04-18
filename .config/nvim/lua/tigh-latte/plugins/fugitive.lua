vim.pack.add {
	gh "tpope/vim-fugitive",
}

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>gst", vim.cmd.Git, opts)
vim.keymap.set("n", "<Leader>gbl", wrap(vim.cmd.Git, "blame"), opts)

vim.keymap.set("n", "<Leader>glog", wrap(vim.cmd.Git, "log -p %"), opts)

vim.keymap.set("n", "<Leader>ghub", vim.cmd.GBrowse, opts)
