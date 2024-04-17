return {
	"tpope/vim-fugitive",
	config = function()
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<Leader>git", vim.cmd.Git, opts)

		vim.keymap.set("n", "<Leader>gst", vim.cmd.Git, opts)

		vim.keymap.set("n", "<Leader>gbl", function()
			vim.cmd.Git("blame")
		end, opts)

		vim.keymap.set("n", "<Leader>glog", function()
			vim.cmd.Git("log -p %")
		end)
	end,
}
