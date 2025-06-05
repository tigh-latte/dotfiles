local augroup = vim.api.nvim_create_augroup("tigh-latte", {})

-- Remove whitespace at end of line.
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = "*",
	command = [[%s/\s\+$//ge]],
})

local ftnolines = setmetatable({
	terminal = true,
	nofile = true,
}, {
	__index = function(_, _)
		return false
	end,
})

-- Only have relativenumber display in the buffer with focus.
vim.api.nvim_create_autocmd({ "BufLeave", "TabLeave", "WinLeave" }, {
	group = augroup,
	pattern = "*",
	callback = function()
		if ftnolines[vim.bo.buftype] then return end
		vim.opt_local.relativenumber = false
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "TabEnter", "WinEnter" }, {
	group = augroup,
	nested = true,
	pattern = "*",
	callback = function()
		if ftnolines[vim.bo.buftype] then return end
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})
