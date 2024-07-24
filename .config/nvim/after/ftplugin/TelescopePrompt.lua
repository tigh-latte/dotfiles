local function toggle_oil(dir)
	local bufnr = vim.api.nvim_get_current_buf()
	require("telescope.actions").close(bufnr)
	require("oil").toggle_float(dir)
end

vim.keymap.set("n", "<Leader>o", toggle_oil, { buffer = true, remap = false })
vim.keymap.set("n", "<Leader>O", function()
	toggle_oil(vim.loop.cwd())
end, { buffer = true, remap = false })
