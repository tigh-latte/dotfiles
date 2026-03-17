install(
	gh("j-hui/fidget.nvim")
)

vim.api.nvim_create_autocmd("LspProgress", {
	once = true,
	callback = function()
		require("fidget").setup({
			notification = {
				window = {
					winblend = 0,
					y_padding = 3,
				},
			},
		})
	end
})
