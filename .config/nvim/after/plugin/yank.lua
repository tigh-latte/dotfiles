-- Easier yank into system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', {})
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+Y', {})

-- Easy delete into void buffer
for _, cmd in ipairs({ "p", "d", "c", "s" }) do
	local CMD = string.upper(cmd)
	vim.keymap.set({ "n", "v" }, "<Leader>" .. cmd, '"_' .. cmd, {})
	vim.keymap.set({ "n", "v" }, "<Leader>" .. CMD, '"_' .. CMD, {})
end

vim.keymap.set("n", "yp", "yyp", {})
vim.keymap.set("n", "yc", "yygccp", { remap = true })
vim.keymap.set("v", "<Leader><Leader>y", "ygvgcgv<ESC>p", { remap = true })
vim.keymap.set("v", "<Leader><Leader>Y", "ygvgcP", { remap = true })

vim.keymap.set("i", "<C-r><C-r>", "<C-r>+", {})

-- finally on this bandwagon too
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("tigh-latte-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
