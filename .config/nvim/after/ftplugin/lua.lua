local function expand(char)
	local line = vim.api.nvim_get_current_line()

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	if line:sub(col, col) ~= char then
		vim.api.nvim_feedkeys(char, "n", true)
		return
	end

	for i = col - 1, 1, -1 do
		local c = line:sub(i, i)
		if c:match("%s") then
			local word = unpack(vim.api.nvim_buf_get_text(0, row - 1, i, row - 1, col - 1, {}))

			local new_text = word .. " = " .. word .. " " .. char .. " 1"
			vim.api.nvim_buf_set_text(0, row - 1, i, row - 1, col, { new_text })

			vim.api.nvim_win_set_cursor(0, { row, col + #word + 6 })
			vim.api.nvim_feedkeys("+", "n", true)
			break
		end
	end
end

for _, char in ipairs { "+" } do
	vim.keymap.set("i", char, function() expand(char) end, {})
end
