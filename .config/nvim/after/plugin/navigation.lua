-- Simple split window navigation.
vim.keymap.set({ "n", "v" }, "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })

-- Use , and . to change the indection within the current set of { }
vim.keymap.set({ "n", "v" }, "<Leader>,", "<i}", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>.", ">i}", { noremap = true })

-- After paging the window forward or backward, recentre the screen on the cursor.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Make <Esc> easier to reach on a macbook.
vim.keymap.set({ "i", "v" }, "§", "<Esc>", { noremap = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
	if not vim.snippet.active({ direction = 1 }) then
		return "<C-n>"
	end
	vim.snippet.jump(1)
end, { expr = true })


vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if not vim.snippet.active({ direction = -1 }) then
		return "<C-p>"
	end
	vim.snippet.jump(-1)
end, { expr = true })
