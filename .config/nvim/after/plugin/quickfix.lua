local tigh_latte_group = vim.api.nvim_create_augroup("tigh-latte-quickfix", {})

-- Rebind <C-P> to select the previous item in the quickfix menu, without
-- rebinding it in other buffers.
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = tigh_latte_group,
	pattern = "*quickfix*",
	callback = function()
		if vim.bo.ft == "qf" then
			vim.keymap.set("n", "<C-P>", "k", { buffer = true, remap = false })
		end
	end,
})
