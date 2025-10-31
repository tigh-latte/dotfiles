-- local win_augroup = vim.api.nvim_create_augroup("tigh-latte-wingroup", { clear = true })
-- vim.api.nvim_create_autocmd("WinResized", {
-- 	group = win_augroup,
-- 	command = "wincmd =",
-- })

local unit = 1

vim.keymap.set({ "n", "t" }, "<M-j>", function()
	local l = vim.api.nvim_win_get_position(0)[1]
	local h = vim.api.nvim_win_get_height(0)

	local ui = vim.api.nvim_list_uis()[1]
	if h + 3 > ui.height then
		return
	end

	h = h + (l == 0 and unit or -unit)

	vim.api.nvim_win_set_height(0, h)
end, {})

vim.keymap.set({ "n", "t" }, "<M-k>", function()
	local l = vim.api.nvim_win_get_position(0)[1]
	local h = vim.api.nvim_win_get_height(0)

	local ui = vim.api.nvim_list_uis()[1]
	if h + 3 > ui.height then
		return
	end

	h = h + (l == 0 and -unit or unit)

	vim.api.nvim_win_set_height(0, h)
end, {})

vim.keymap.set({ "n", "t" }, "<M-h>", function()
	local l = vim.api.nvim_win_get_position(0)[2]
	local w = vim.api.nvim_win_get_width(0)

	w = w + 2 * (l == 0 and -unit or unit)

	vim.api.nvim_win_set_width(0, w)
end, {})

vim.keymap.set({ "n", "t" }, "<M-l>", function()
	local l = vim.api.nvim_win_get_position(0)[2]
	local w = vim.api.nvim_win_get_width(0)

	w = w + 2 * (l == 0 and unit or -unit)

	vim.api.nvim_win_set_width(0, w)
end, {})
