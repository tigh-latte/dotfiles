vim.pack.add {
	gh "https://github.com/windwp/nvim-autopairs",
}

vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("nvim-autopairs").setup({})
	end
})
