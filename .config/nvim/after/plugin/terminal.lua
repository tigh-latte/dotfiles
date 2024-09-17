-- Return a function which will open a zsh terminal using the provided
-- function. Intended to be used with a keybinding for splitting
-- horizontal or vertical.
--- @param fn function
--- @return function
local function build_term(fn)
	return function()
		fn("term://zsh")
	end
end

vim.keymap.set("n", "<Leader>v", build_term(vim.cmd.vsplit), { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>a", build_term(vim.cmd.split), { noremap = true, silent = true })

-- Window navigation while in a terminal buffer made much, much easier.
vim.api.nvim_set_keymap("t", "<C-N>", "<C-\\><C-N>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-H>", "<C-\\><C-N><C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-J>", "<C-\\><C-N><C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-K>", "<C-\\><C-N><C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("t", "<C-L>", "<C-\\><C-L>", { noremap = true })

local augroup = vim.api.nvim_create_augroup("TerminalHelpers", { clear = true })

-- When entering a terminal buffer, by opening or moving window, enter insert
-- mode.
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	pattern = "term://*",
	callback = function() vim.cmd("startinsert") end,
})

-- We don't want any numbers in our terminal.
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	pattern = "term://*",
	callback = function()
		vim.opt_local.number = false
	end,
})

-- We don't want ANY numbers in our terminal.
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	pattern = "term://*",
	callback = function()
		vim.opt_local.relativenumber = false
	end,
})

-- Close the terminal buffer when the terminal closes, no point holding on.
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	pattern = "term://*",
	nested = true,
	callback = function(opts)
		vim.api.nvim_buf_delete(opts.buf, { force = true })
	end,
})
