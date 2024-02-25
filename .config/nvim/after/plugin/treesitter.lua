require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua", "vim", "vimdoc", "query", "typescript", "python" },
	ignore_install = {},
	modules = {},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})
