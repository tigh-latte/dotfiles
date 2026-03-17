install(
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context"
)

require("nvim-treesitter").install({
	"printf",
})

vim.treesitter.language.register("bash", "zsh")

vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		require("treesitter-context").setup({
			max_lines = 4,
			multiline_threshold = 4,
		})
	end,
})
