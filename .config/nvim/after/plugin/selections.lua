vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Grows or shrinks the current visual selection
--- @param action string can be "grow" or "shrink"
local function visual_regrow(action)
	assert(action == "grow" or action == "shrink")

	-- Change to Visual Line mode if in Visual. Consider going this for
	-- Visual Block mode as well.
	local mode = vim.api.nvim_get_mode().mode
	vim.api.nvim_input((mode == "v" and "<S-v>" or ""))

	local cpos = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_input("o")

	-- I donno the cursor position doesn't update right away or something, so
	-- schedule this instead.
	vim.schedule(function()
		local npos = vim.api.nvim_win_get_cursor(0)[1]
		vim.api.nvim_input("o")

		-- Nothing left to shrink
		if action == "shrink" and math.abs(cpos - npos) < 2 then
			return
		end

		-- perform the action
		local a = action == "grow" and { "joko", "kojo" } or { "kojo", "joko" }
		local b = cpos > npos and a[1] or a[2]
		vim.api.nvim_input(b)
	end)
end


-- Grow the top and bottom lines outward by one line each.
vim.keymap.set("v", ")", function() visual_regrow("grow") end, {})

-- Shrink the top and bottom lines inward by one line each.
vim.keymap.set("v", "(", function() visual_regrow("shrink") end, {})
