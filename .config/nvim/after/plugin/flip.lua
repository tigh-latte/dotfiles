local pairings = {
	["0"] = 1,
	["1"] = 0,
	["t"] = "f",
	["f"] = "t",
	["true"] = "false",
	["false"] = "true",
	["True"] = "False",
	["False"] = "True",
}
local function toggle()
	local word = vim.fn.expand("<cword>")
	local flip = pairings[word]
	if not flip then return end

	local _, before = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("norm! ciw" .. flip)
	local row, after = unpack(vim.api.nvim_win_get_cursor(0))
	if before < after then
		vim.api.nvim_win_set_cursor(0, { row, before })
	end
end

vim.api.nvim_create_user_command("Flip", toggle, { nargs = 0 })

vim.keymap.set("n", "<Leader>;", vim.cmd.Flip)
