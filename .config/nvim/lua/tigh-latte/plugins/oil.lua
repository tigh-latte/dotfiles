return {
	"stevearc/oil.nvim",
	config = function()
		local oil = require("oil")
		oil.setup({
			columns = {},
			skip_confirm_for_simple_edits = true,
			constrain_cursor = "editable",
			use_default_keymaps = false,
			view_options = {
				show_hidden = true,
				natural_order = false,
				is_hidden_file = function(name, _)
					return vim.startswith(name, ".")
				end,
			},
			confirmation = {
				border = "rounded",
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
		vim.keymap.set({ "n", "v" }, "<Leader>O", function() oil.toggle_float((vim.uv or vim.loop).cwd()) end, {})

		local augroup = vim.api.nvim_create_augroup("tigh-oil", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			nested = true,
			group = augroup,
			callback = function(ev)
				if vim.bo.ft ~= "oil" then return end
				vim.keymap.set("n", "<C-p>", function()
					require("oil").close()
					require("telescope.builtin").find_files()
				end, { buffer = ev.buf, remap = false })
			end,
		})
	end,
}
