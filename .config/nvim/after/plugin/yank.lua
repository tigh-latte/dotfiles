-- Easier yank into and paste from system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", "\"+y", {})
vim.keymap.set({ "n", "v" }, "<Leader>Y", "\"+Y", {})
vim.keymap.set({ "n", "v" }, "<Leader>p", "\"+p", {})
vim.keymap.set({ "n", "v" }, "<Leader>P", "\"+P", {})
vim.keymap.set({ "n", "v" }, "<Leader>d", "\"_d", {})
vim.keymap.set("i", "<C-r><C-r>", "<C-r>+", {})

-- finally on this bandwagon too
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("tigh-latte-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
