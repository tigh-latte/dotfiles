vim.keymap.set("n", "<Leader>gst", vim.cmd.Git)
vim.keymap.set("n", "<Leader>gbb", function()
	vim.cmd.Git()
end)
