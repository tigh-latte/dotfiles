return {
	{ "Bilal2453/luvit-meta",     lazy = true },
	{ "tigh-latte/wezterm-types", lazy = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = function()
			require("lazydev").setup({
				---@type lazydev.Library.spec
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "wezterm-types",      mods = { "wezterm" } },
				},
			})

			local augroup = vim.api.nvim_create_augroup("tigh-lazy", { clear = true })
			vim.api.nvim_create_autocmd("BufEnter", {
				group = augroup,
				callback = vim.schedule_wrap(function(ev)
					if vim.bo.ft ~= "lazy" then return end
					vim.keymap.set("n", "<C-p>", function()
						require("lazy.view").view:close({})
						require("telescope.builtin").find_files()
					end, { buffer = ev.buf, remap = false })
				end),
			})
		end,
	},
}
