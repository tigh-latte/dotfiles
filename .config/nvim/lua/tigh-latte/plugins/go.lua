return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		-- Disable all the lsp stuff as the LSP is already configured in this setup.
		require("go").setup({
			lsp_codelens = false,
			lsp_inlay_hints = {
				enable = false,
			},
		})

		local augroup = vim.api.nvim_create_augroup("tigh-latte-golang", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = augroup,
			pattern = "*.go",
			callback = function()
				local opts = { remap = false, buffer = true, silent = true }
				vim.keymap.set("n", "<Leader>gcc", vim.cmd.GoCoverage, opts)
				vim.keymap.set("n", "<Leader>gaa", vim.cmd.GoAltV, opts)
				vim.keymap.set("n", "<Leader>gtt", vim.cmd.GoTest, opts)
				vim.keymap.set("n", "<Leader>gtf", vim.cmd.GoTestFunc, opts)
				vim.keymap.set("n", "<Leader>gti", vim.cmd.GoModTidy, opts)
				vim.keymap.set("n", "<Leader>gve", vim.cmd.GoModVendor, opts)

				vim.keymap.set("n", "<Leader>gg", function()
					vim.api.nvim_input('"zyi":GoGet <C-R>z<CR>')

					vim.schedule(function()
						if vim.fn.isdirectory("vendor") ~= 0 then
							vim.cmd.GoModVendor()
						end
					end)
				end, opts)
			end,
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}
