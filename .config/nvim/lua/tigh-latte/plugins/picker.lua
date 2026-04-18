vim.pack.add {
	gh "ibhagwan/fzf-lua"
}

local fzf = require("fzf-lua")

fzf.setup({
	winopts = {
		on_create = function()
			vim.keymap.set("t", "<C-n>", "<down>", { silent = true, buffer = true })
			vim.keymap.set("t", "<C-p>", "<up>", { silent = true, buffer = true })
			vim.keymap.set("t", "<C-x>", "<C-s>", { silent = true, buffer = true })
		end,
	},
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
		},
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
	files = {
		fd_opts = [[
					--color=never \
					--hidden \
					--type f \
					--type l \
					--exclude .git \
					--exclude .gitmodules \
					--exclude vendor \
					--exclude cdk.out \
					--exclude node_modules \
					--exclude dist \
					--exclude build \
					--exclude __pycache__ \
					--exclude .venv
				]],
	},
	grep = {
		hidden = true,
	},
})
vim.keymap.set("n", "<C-p>", function()
	fzf.files({ cwd_prompt = false })
end, { silent = true })

vim.keymap.set("n", "<Leader>qf", fzf.quickfix, { silent = true })
vim.keymap.set("n", "<Leader>gr", fzf.live_grep, { silent = true })
vim.keymap.set("n", "<Leader>he", fzf.help_tags, { silent = true })
local winopts = {
	height = 0.4,
	title_pos = "left",
	border = { "", "─", "", "", "", "", "", "" },
	preview = {
		border = function(_, m)
			if m.type == "fzf" then
				return "single"
			else
				assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
				local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
				if m.layout == "down" then
					b[1] = "├" --top right
					b[3] = "┤" -- top left
				elseif m.layout == "up" then
					b[7] = "├" -- bottom left
					b[6] = "" -- remove bottom
					b[5] = "┤" -- bottom right
				elseif m.layout == "left" then
					b[3] = "┬" -- top right
					b[5] = "┴" -- bottom right
					b[6] = "" -- remove bottom
				else -- right
					b[1] = "┬" -- top left
					b[7] = "┴" -- bottom left
					b[6] = "" -- remove bottom
				end
				return b
			end
		end,
		layout = "horizontal",
		horizontal = "right:50%",
	},
}
vim.keymap.set("n", "<Leader>cim", function()
	fzf.lsp_implementations({
		silent = true,
		profile = "ivy",
		winopts = winopts,
	})
end, { silent = true })
vim.keymap.set("n", "<Leader>cre", function()
	fzf.lsp_references({
		silent = true,
		profile = "ivy",
		winopts = winopts,
	})
end, { silent = true })

local ttwinopts = vim.tbl_deep_extend("force", winopts, { preview = { horizontal = "right:70%" } })
vim.keymap.set("n", "<Leader>tt", function()
	fzf.lsp_workspace_diagnostics({ silent = true, profile = "ivy", winopts = ttwinopts })
end)
vim.keymap.set("n", "<Leader>/", fzf.lsp_workspace_symbols, { silent = true })
vim.keymap.set("n", "<Leader>cb", fzf.git_branches, { silent = true })

local cawinopts = vim.tbl_deep_extend("force", winopts, { height = 0.2 })
vim.keymap.set("n", "<Leader>ca", function()
	fzf.lsp_code_actions({
		silent = true,
		profile = "ivy",
		winopts = cawinopts,
	})
end, { silent = true })
