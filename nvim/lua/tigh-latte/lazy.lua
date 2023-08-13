local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- General utility
	{"windwp/nvim-autopairs", event = "InsertEnter", opts = {}},
	{"scrooloose/nerdtree"},
	{"ctrlpvim/ctrlp.vim"},
	{
		"chrisgrieser/nvim-various-textobjs",
		lazy = false,
		opts = { useDefaultKeymaps = true },
	},
	{ "vim-airline/vim-airline" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "mbbill/undotree" },

	-- Syntax tree stuff
	{ "nvim-treesitter/nvim-treesitter", opts = { run = ':TSUpdate' } },
	{ "nvim-treesitter/playground" },

	-- LSP and Formatter management
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Hrsh7th completion suite
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/vim-vsnip" },
		},
	},

	-- Go stuff
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = {"CmdlineEnter"},
		ft = {'go', 'gomod'},
		build = ':lua require("go.install").update_all_sync()'
	},

	-- Formatters
	{ "mhartington/formatter.nvim" },
}, {})
