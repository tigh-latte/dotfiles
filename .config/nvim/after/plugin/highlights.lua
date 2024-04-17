vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- finally on this bandwagon too
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("tigh-latte-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "vv", "<S-v>", {}) -- Testing out this way to get into visual line mode
