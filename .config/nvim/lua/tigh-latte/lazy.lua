local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local localplugins = vim.fn.stdpath("config") .. "/lua/tigh-latte/plugins/local"
require("lazy").setup({
	{ import = "tigh-latte.plugins" },
	(vim.uv or vim.loop).fs_stat(localplugins) and { import = "tigh-latte.plugins.local" } or {},
}, {
	change_detection = {
		notify = false,
	},
})
