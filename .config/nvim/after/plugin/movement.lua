vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ "n", "v" }, "n", "nzz", { silent = true })
vim.keymap.set({ "n", "v" }, "N", "Nzz", { silent = true })

local function visual_regrow(forward, backward)
	vim.api.nvim_input("<Esc>")

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


vim.keymap.set("v", "<C-o>", function() visual_regrow("joko", "kojo") end, {})

vim.keymap.set("v", "<C-i>", function() visual_regrow("kojo", "joko") end, {})
