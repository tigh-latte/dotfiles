-- Move visual selected lines up or down.
-- Has the same effect as just deleting the text and pasting it where
-- you'd like, but is visually nicer.
-- NOTE: this spams your undo history.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ "n", "v" }, "n", "nzz", { silent = true })
vim.keymap.set({ "n", "v" }, "N", "Nzz", { silent = true })
vim.keymap.set("n", "<Leader>he", require("telescope.builtin").help_tags, { silent = true })

vim.keymap.set("n", "gs", "<Nop>", { silent = true, remap = false })


---@param target string
---@param direction "forward"|"backward"
---@return function
local function split(target, direction)
	assert(target:len() == 1)

	return function()
		unpack = table.unpack or unpack

		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local pchar = vim.api.nvim_buf_get_text(0, row - 1, col, row - 1, col + 1, {})[1]

		local cmd = (direction == "forward" and "a" or "i") .. "<CR><ESC>^"
		if pchar ~= target then
			cmd = "f" .. target .. cmd
		end

		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes(cmd, true, true, true),
			"normal!",
			false
		)
	end
end

for direction, chars in pairs({ forward = { ",", "(" }, backward = { ")" } }) do
	for _, char in ipairs(chars) do
		local fn = split(char, direction)
		local key = "<C-S-" .. char .. ">"

		vim.keymap.set("n", key, fn, { silent = true, remap = false })
	end
end
