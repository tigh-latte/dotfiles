return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<Leader>git", vim.cmd.Git)

		vim.keymap.set("n", "<Leader>gst", function()
			vim.cmd.Git("status")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "<Leader>gbl", function()
			vim.cmd.Git("blame")
		end, { noremap = true, silent = true })
	end,
}
