vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "vv", "<S-v>", {}) -- Testing out this way to get into visual line mode

-- Grows or shrinks the current visual selection etiher.
--- @param forward string
--- @param backward string
local function visual_regrow(forward, backward)
	local mode = vim.api.nvim_get_mode().mode
	vim.api.nvim_input((mode == "v" and "<S-v>" or "") .. "<Esc>")

	vim.schedule(function()
		local startl = vim.api.nvim_buf_get_mark(0, "<")[1]
		local pos = vim.api.nvim_win_get_cursor(0)[1]

		local cmds = forward
		if pos == startl then
			cmds = backward
		end

		vim.api.nvim_input("gv" .. cmds)
	end)
end


-- Grow the top and bottom lines outward by one line each.
vim.keymap.set("v", ")", function() visual_regrow("joko", "kojo") end, {})

-- Shrink the top and bottom lines inward by one line each.
vim.keymap.set("v", "(", function() visual_regrow("kojo", "joko") end, {})
