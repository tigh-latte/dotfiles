return {
	"ctrlpvim/ctrlp.vim",
	config = function()
		vim.g.ctrlp_show_hidden = 1
		vim.g.ctrlp_working_path_mode = 0
		vim.g.ctrlp_custom_ignore = {
			dir = "\\v[\\/]\\.(git|svn|hg)|vendor|node_modules",
			file = "\\v\\.(so|pyc|swp|git)$",
		}
	end,
}