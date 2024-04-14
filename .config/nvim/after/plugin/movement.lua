-- Move visual selected lines up or down.
-- Has the same effect as just deleting the text and pasting it where
-- you'd like, but is visually nicer.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ "n", "v" }, "n", "nzz", { silent = true })
vim.keymap.set({ "n", "v" }, "N", "Nzz", { silent = true })

-- Grows or shrinks the current visual selection etiher.
--- @param forward string
--- @param backward string
local function visual_regrow(forward, backward)
	local mode = vim.api.nvim_get_mode().mode
	vim.api.nvim_input((mode == "v" and "<S-v>" or "") .. "<Esc>")

	vim.schedule(function()
		local startl = vim.api.nvim_buf_get_mark(0, "<")[1]
		local pos = vim.api.nvim_win_get_cursor(0)[1]

		local expand = forward
		if pos == startl then
			expand = backward
		end

		vim.api.nvim_input("gv" .. expand)
	end)
end


-- Grow the top and bottom lines outward by one line each.
vim.keymap.set("v", "<C-o>", function() visual_regrow("joko", "kojo") end, {})

-- Shrink the top and bottom lines inward by one line each.
vim.keymap.set("v", "<C-i>", function() visual_regrow("kojo", "joko") end, {})
