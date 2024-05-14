return {
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/vim-vsnip" },
			{ "hrsh7th/cmp-calc" },
		},
		config = function()
			require("tigh-latte.lsp").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
