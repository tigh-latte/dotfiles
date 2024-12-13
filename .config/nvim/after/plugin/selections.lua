vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Grows or shrinks the current visual selection
--- @param action string can be "grow" or "shrink"
local function visual_regrow(action)
	assert(action == "grow" or action == "shrink")

	-- Change to Visual Line mode if in Visual. Consider going this for
	-- Visual Block mode as well.
	local mode = vim.api.nvim_get_mode().mode
	-- vim.api.nvim_input((mode == "v" and "<S-v>" or ""))
	vim.api.nvim_feedkeys((mode == "v" and "<S-v>" or ""), "n", false)

	local npos = vim.fn.getpos("v")[2]
	local cpos = vim.api.nvim_win_get_cursor(0)[1]

	if action == "shrink" then
		if cpos == npos then return "" end -- nothing left to shrink
		return ({ "kojo", "joko" })[cpos < npos and 2 or 1]
	end


	local max_lines = vim.api.nvim_buf_line_count(0)
	if action == "grow" then
		local cmd = ""
		if cpos >= npos and cpos < max_lines then
			cmd = cmd .. "j"
		elseif cpos <= npos and cpos > 1 then
			cmd = cmd .. "k"
		end
		cmd = cmd .. "o"

		if npos <= cpos and npos > 1 then
			cmd = cmd .. "k"
		elseif npos >= cpos and npos < max_lines then
			cmd = cmd .. "j"
		end

		cmd = cmd .. "o"

		return cmd
	end
end

-- Moves the selection window (not the text) either up or down
--- @param direction string can be "up" or "down"
local function visual_move(direction)
	assert(direction == "up" or direction == "down")
	return ({ up = "koko", down = "jojo" })[direction]
end


-- Grow the top and bottom lines outward by one line each.
vim.keymap.set("v", ")", function() return visual_regrow("grow") end, { expr = true })

-- Shrink the top and bottom lines inward by one line each.
vim.keymap.set("v", "(", function() return visual_regrow("shrink") end, { expr = true })

-- Move the selection upwards.
vim.keymap.set("v", "<M-k>", function() return visual_move("up") end, { expr = true })

-- Move the selection downwards.
vim.keymap.set("v", "<M-j>", function() return visual_move("down") end, { expr = true })

-- Execute lua selection.
vim.keymap.set("v", "<Leader>x", ":'<,'>lua<CR>", { silent = true })

-- Execute lua file.
vim.keymap.set("n", "<Leader>x", function()
	if vim.bo.ft ~= "lua" then
		vim.notify("can only execute lua files", vim.log.levels.ERROR, {})
		return
	end
	vim.api.nvim_feedkeys(":%lua" .. vim.keycode("<CR>"), "n", false)
end, {})
