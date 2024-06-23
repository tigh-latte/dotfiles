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

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("tigh-latte", {}),
	pattern = "*",
	command = [[%s/\s\+$//ge]],
})
