local augroup = vim.api.nvim_create_augroup("tigh-latte-dotfiles", { clear = false })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = ".config/swayosd/*",
	callback = function()
		vim.cmd("!pkill swayosd-server")
		vim.cmd([[!somewm-client eval 'require("awful").spawn("swayosd-server")']])
	end,
})
