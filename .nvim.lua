local augroup = vim.api.nvim_create_augroup("tigh-latte-dotfiles", { clear = false })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = ".config/sway/*",
	command = "!swaymsg reload",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = ".config/swaync/*",
	command = "!swaync-client -R",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = ".config/waybar/*",
	callback = function()
		vim.cmd("!swaymsg exec pkill waybar")
		vim.cmd("!swaymsg exec waybar")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = ".config/swayosd/*",
	callback = function()
		vim.cmd("!swaymsg exec pkill swayosd-server")
		vim.cmd("!swaymsg exec swayosd-server")
	end,
})
