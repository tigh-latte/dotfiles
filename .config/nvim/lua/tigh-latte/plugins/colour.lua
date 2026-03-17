install(
	gh("catgoose/nvim-colorizer.lua")
)

vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		require("colorizer").setup({
			user_default_options = {
				names = false,
			},
		})
	end,
})
