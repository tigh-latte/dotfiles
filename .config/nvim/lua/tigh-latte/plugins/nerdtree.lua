return {
	"scrooloose/nerdtree",
	dependencies = {
		{ "PhilRunninger/nerdtree-visual-selection" },
	},
	event = "VeryLazy",

	config = function()
		vim.g.NERDTreeIgnore = { "\\.pyc$", "\\~$", "\\.swp$" }
		vim.g.NERDTreeGitStatusShowIgnored = 1
		vim.g.NERDTreeGitStatusConcealBrackets = 1
		vim.keymap.set("n", "<Leader>n", vim.cmd.NERDTreeToggle, { noremap = true, silent = true })
		vim.keymap.set("n", "<Leader>f", vim.cmd.NERDTreeFind, { noremap = true, silent = true })
		vim.cmd([[
    let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Ignored'     : '!',
      \ }
]])
	end,
}
