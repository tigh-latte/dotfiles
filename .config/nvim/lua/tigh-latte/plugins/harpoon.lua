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

		vim.keymap.set("n", "<C-S-a>", function() harpoon:list():add() end, {})
		vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {})
		vim.keymap.set("n", "<C-S-t>", function() harpoon:list():select(1) end, {})
		vim.keymap.set("n", "<C-S-y>", function() harpoon:list():select(2) end, {})
		vim.keymap.set("n", "<C-S-g>", function() harpoon:list():select(3) end, {})
		vim.keymap.set("n", "<C-S-h>", function() harpoon:list():select(4) end, {})
		vim.keymap.set("n", "<C-S-b>", function() harpoon:list():select(5) end, {})
		vim.keymap.set("n", "<C-S-n>", function() harpoon:list():select(6) end, {})
	end,
}
