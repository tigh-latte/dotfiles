return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<Leader>uu", vim.cmd.UndotreeToggle)
	end,
}
