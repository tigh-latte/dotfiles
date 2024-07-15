return {
	"stevearc/oil.nvim",
	config = function()
		local oil = require("oil")
		oil.setup({
			columns = { "icon" },
			skip_confirm_for_simple_edits = true,
			-- constrain_cursor = "name",
			constrain_cursor = "editable",
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
				natural_order = false,
				is_hidden_file = function(name, _)
					return vim.startswith(name, ".")
				end,
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<Leader>i"] = "actions.toggle_hidden",
				["<Leader>r"] = "actions.refresh",
				["<Leader>p"] = "actions.preview",
				["<Leader>CD"] = "actions.open_cwd",
				["<Leader>cd"] = "actions.cd",
				["<CR>"] = "actions.select",
				["<C-x>"] = {
					"actions.select",
					opts = {
						horizontal = true,
					},
					desc = "horizontal split",
				},
				["<C-v>"] = {
					"actions.select",
					opts = {
						vertical = true,
					},
					desc = "vertical split",
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<Leader>o", function() oil.toggle_float() end, {})
		vim.keymap.set({ "n", "v" }, "<Leader>O", function() oil.toggle_float(vim.loop.cwd()) end, {})
	end,
}
