vim.cmd.packadd({ "nvim.undotree" })
vim.keymap.set("n", "<Leader>uu", function()
	require("undotree").open({
		command = "set nosplitright | 30vnew | set splitright"
	})
end)
