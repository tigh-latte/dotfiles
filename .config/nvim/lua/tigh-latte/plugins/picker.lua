local picker = os.getenv("NVIM_PICKER")
return { {
	"nvim-telescope/telescope.nvim",
	lazy = picker ~= "telescope",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local vimgrep_arguments = {
			"rg",
			"--hidden",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--glob=!/**/vendor/*",
			"--glob=!/**/node_modules/*",
			"--glob=!/**/.git/*",
			"--glob=!/**/.gitmodules",
			"--glob=!/**/.venv/*",
		}

		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				fzf = {},
			},
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"vendor",
					"target",
					"dist",
					"build/",
					"*.min.*",
					"__.*",
					"^tmp/",
					"^main$",
					".git/",
					".venv/",
					"cdk.out/",
				},
				vimgrep_arguments = vimgrep_arguments,
			},
			pickers = {
				lsp_references = {
					theme = "ivy",
				},
				live_grep = {
					disable_devicons = true,
				},
				git_files = {
					disable_devicons = true,
				},
				grep_string = {
					disable_devicons = true,
				},
				find_files = {
					disable_devicons = true,
					hidden = true,
					no_ignore = true,
					sorting_strategy = "descending",
					layout_config = {
						prompt_position = "bottom",
					},
				},
			},
		})
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-P>", builtin.find_files, { silent = true })
		vim.keymap.set("n", "<Leader>grep", builtin.live_grep, { silent = true }) -- consider a handier binding.
		vim.keymap.set("n", "<Leader>cb", builtin.git_branches, { silent = true })
		vim.keymap.set("n", "<Leader>he", require("telescope.builtin").help_tags, { silent = true })
		vim.keymap.set("n", "<Leader>cref", builtin.lsp_references, { remap = false })
		vim.keymap.set("n", "<Leader>/", builtin.lsp_dynamic_workspace_symbols, { remap = false })

		local augroup = vim.api.nvim_create_augroup("tigh-telescope", { clear = true })
		vim.api.nvim_create_autocmd("BufEnter", {
			group = augroup,
			nested = true,
			callback = vim.schedule_wrap(function(ev)
				if vim.bo.ft ~= "TelescopePrompt" then return end

				local function toggle_oil(dir)
					require("telescope.actions").close(ev.buf)
					require("oil").toggle_float(dir)
				end

				vim.keymap.set("n", "<Leader>o", toggle_oil, { buffer = true, remap = false })
				vim.keymap.set("n", "<Leader>O", function()
					toggle_oil((vim.uv or vim.loop).cwd())
				end, { buffer = ev.buf, remap = false })
			end),
		})
	end,
}, {
	"ibhagwan/fzf-lua",
	lazy = picker ~= nil and picker ~= "fzf",
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				on_create = function()
					vim.keymap.set("t", "<C-n>", "<down>", { silent = true, buffer = true })
					vim.keymap.set("t", "<C-p>", "<up>", { silent = true, buffer = true })
					vim.keymap.set("t", "<C-x>", "<C-s>", { silent = true, buffer = true })
				end,
			},
			fzf_colors = {
				pointer = { "fg", "fzfLuaPointer" },
				prompt = { "fg", "fzfLuaPrompt" },
			},
			keymap = {
				builtin = {
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
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

		vim.keymap.set("n", "<Leader>gr", fzf.live_grep, { silent = true })
		vim.keymap.set("n", "<Leader>he", fzf.help_tags, { silent = true })
		vim.keymap.set("n", "<Leader>cre", function() fzf.lsp_references({ profile = "ivy" }) end, { silent = true })
		vim.keymap.set("n", "<Leader>/", fzf.lsp_workspace_symbols, { silent = true })
		vim.keymap.set("n", "<Leader>cb", fzf.git_branches, { silent = true })
		vim.keymap.set("n", "<Leader>ca", function()
			fzf.lsp_code_actions({
				silent = true,
				profile = "ivy",
				winopts = { height = 0.1 },
			})
		end, { silent = true })
	end,
} }
