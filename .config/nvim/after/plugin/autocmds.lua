local augroup = vim.api.nvim_create_augroup("tigh-latte", {})

-- Remove whitespace at end of line.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = "*",
	command = [[%s/\s\+$//ge]],
})

-- Only have relativenumber display in the buffer with focus.
vim.api.nvim_create_autocmd({ "BufLeave", "TabLeave", "WinLeave" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "terminal" then return end
		vim.opt_local.relativenumber = false
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "TabEnter", "WinEnter" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "terminal" then return end
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})
