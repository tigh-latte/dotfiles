return {
	"https://github.com/folke/trouble.nvim",
	config = function()
		require("trouble").setup({})

		--vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
		vim.keymap.set("n", "<leader>tt", function()
			require("trouble.api").toggle({
				mode = "diagnostics",
			})
		end, { silent = true })
	end,
}
