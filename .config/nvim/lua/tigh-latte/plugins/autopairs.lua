install(
	gh("https://github.com/windwp/nvim-autopairs")
)
-- vim.pack.add({
-- 	"https://github.com/windwp/nvim-autopairs",
-- }, {
-- 	load = false,
-- })

vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("nvim-autopairs").setup({})
	end
})
