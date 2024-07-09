vim.keymap.set("n", "<C-p>", function()
	require("lazy.view").view:close({})
	require("telescope.builtin").find_files()
end, { buffer = true, remap = false })
