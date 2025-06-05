-- Move visual selected lines up or down.
-- Has the same effect as just deleting the text and pasting it where
-- you'd like, but is visually nicer.
-- NOTE: this spams your undo history.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ "n", "v" }, "n", "nzz", { silent = true })
vim.keymap.set({ "n", "v" }, "N", "Nzz", { silent = true })

vim.keymap.set("n", "gs", "<Nop>", { silent = true, remap = false })

vim.keymap.set({ "n", "v" }, "(", function()
	local unpack = table.unpack or unpack
	local cur_line = unpack(vim.api.nvim_win_get_cursor(0))

	if cur_line - 1 <= 1 then return "{" end

	local lines = vim.api.nvim_buf_get_lines(0, 0, cur_line - 1, false)

	local next_line = lines[#lines]
	table.remove(lines, #lines)

	if next_line:len() == 0 then
		for i = 1, #lines do
			local line = lines[#lines - (i - 1)]
			if line:len() == 0 then return "k{j^" end
		end
		return "k{"
	else
		local paragraphs = 0
		for i = 1, #lines do
			local line = lines[#lines - (i - 1)]
			if line:len() == 0 then paragraphs = paragraphs + 1 end
			if paragraphs == 2 then return "{j^" end
		end
	end

	return "{j^"
end, { remap = false, silent = true, expr = true })

vim.keymap.set({ "n", "v" }, ")", function()
	local unpack = table.unpack or unpack
	local cur_line = unpack(vim.api.nvim_win_get_cursor(0))
	local total_lines = vim.api.nvim_buf_line_count(0)

	if cur_line + 1 >= total_lines then return "}" end

	local lines = vim.api.nvim_buf_get_lines(0, cur_line, -1, false)
	local next_line = lines[1]
	table.remove(lines, 1)

	if next_line:len() == 0 then
		for _, line in ipairs(lines) do
			if line:len() == 0 then return "j}k$" end
		end
		return "j}"
	else
		local paragraphs = 0
		for _, line in ipairs(lines) do
			if line:len() == 0 then paragraphs = paragraphs + 1 end
			if paragraphs == 2 then return "}k$" end
		end
	end

	return "}k$"
end, { remap = false, silent = true, expr = true })

vim.keymap.set({ "n", "v" }, "])", function()
	local unpack = table.unpack or unpack
	local cur_line, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	local total_lines = vim.api.nvim_buf_line_count(0)

	local prefix = cur_col > 0 and tostring(cur_col) .. "l" or ""

	if cur_line + 1 >= total_lines then return "}0" .. prefix end

	local lines = vim.api.nvim_buf_get_lines(0, cur_line, -1, false)
	local next_line = lines[1]
	table.remove(lines, 1)

	if next_line:len() == 0 then
		for _, line in ipairs(lines) do
			if line:len() == 0 then return "j}k0" .. prefix end
		end
		return "j}"
	else
		local paragraphs = 0
		for _, line in ipairs(lines) do
			if line:len() == 0 then paragraphs = paragraphs + 1 end
			if paragraphs == 2 then return "}k0" .. prefix end
		end
	end
end, { remap = false, silent = true, expr = true })

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

		vim.keymap.set("n", "<Leader>" .. char, fn, { remap = false })
	end
end
