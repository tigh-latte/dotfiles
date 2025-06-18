return {
	setup = function()
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
			install = { colorscheme = { "onedark" } },
		}, {
			change_detection = {
				notify = false,
			},
		})

		local augroup = vim.api.nvim_create_augroup("tigh-lazy", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = augroup,
			nested = true,
			callback = vim.schedule_wrap(function(ev)
				if vim.bo.ft ~= "lazy" then return end
				vim.keymap.set("n", "<C-p>", function()
					require("lazy.view").view:close({})
					require("telescope.builtin").find_files()
				end, { buffer = ev.buf, remap = false })
			end),
		})
	end,
}
