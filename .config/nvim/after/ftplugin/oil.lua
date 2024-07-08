vim.keymap.set("n", "<C-p>", function()
	require("oil").close()
	require("telescope.builtin").find_files()
end, { buffer = true, remap = false })
