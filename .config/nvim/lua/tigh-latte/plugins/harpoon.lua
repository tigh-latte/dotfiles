return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		local h = function(idx)
			vim.cmd.stopinsert()
			harpoon:list():select(idx)
		end

		vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-a>", function() harpoon:list():add() end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-t>", function() h(1) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-y>", function() h(2) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-g>", function() h(3) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-h>", function() h(4) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-b>", function() h(5) end, {})
		vim.keymap.set({ "n", "i" }, "<C-S-n>", function() h(6) end, {})
	end,
}
