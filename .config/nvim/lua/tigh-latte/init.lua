-- Custom leader key per OS. This was relevant when I used the mac keyboard, but isn't
-- now. Am keeping just incase OS specific stuff is needed in the future.
(setmetatable({
	Darwin = function()
		vim.keymap.set("n", "`", "<Nop>", { silent = true, remap = false })
		vim.g.mapleader = " "
	end,
}, {
	__index = function(_, _)
		return function() vim.g.mapleader = " " end
	end,
}))[vim.loop.os_uname().sysname]()

require("tigh-latte.lazy")

local augroup = vim.api.nvim_create_augroup("tigh-latte", {})


vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = "*",
	command = [[%s/\s\+$//ge]],
})

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
