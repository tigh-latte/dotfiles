-- Consider learning how to do this, so you don't need to use a theme's underlying
-- engine to apply your own custom theme.
return {
	{
		"navarasu/onedark.nvim",
		event = "VeryLazy",
		config = function()
			require("onedark").setup({
				style = "dark",
				term_colors = false,
				transparent = true,
				toggle_style_key = "<Leader>ts",
				toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },

				colors = {
					red = "#af5f5a",
					green = "#53892c",
					muted_pink = "#af87af",
					yellow = "#d7af87",
					cyan = "#5fafaf",

					dark_purple = "#ba68c8",

					white = "#f8f8f2",
					muted_white = "#b1b1b1",
					light_grey = "#7d899f",

					fg = "#abb2bf",
					bg0 = "#282c34",
					bg1 = "#3a3a3a",
					bg2 = "#393f4a",
					bg3 = "#3b3f4c",
				},
				highlights = {
					CurSearch = { fg = "$bg0", bg = "$light_grey" },
					IncSearch = { fg = "$bg0", bg = "$light_grey" },
					Search = { fg = "$bg0", bg = "$muted_white" },
					Directory = { fg = "$cyan" },
					Special = { fg = "$cyan" },
					SpecialChar = { fg = "$cyan" },
					Structure = { fg = "$fg" },
					Typedef = { fg = "$fg" },
					Function = { fg = "$fg" },

					-- keywords
					["@keyword"] = { fg = "$yellow" },
					["@conditional"] = { fg = "$yellow" },
					["@keyword.conditional"] = { fg = "$yellow" },
					["@keyword.function"] = { fg = "$yellow" },
					["@include"] = { fg = "$yellow" },
					["@keyword.import"] = { fg = "$yellow" },
					["@keyword.operator"] = { fg = "$yellow" },
					["@keyword.exception"] = { fg = "$yellow" },
					["@keyword.directive"] = { fg = "$yellow" },
					["@keyword.repeat"] = { fg = "$yellow" },
					["@lsp.type.builtinType"] = { fg = "$green" },
					["@type"] = { fg = "$fg" },
					["@type.builtin"] = { fg = "$green" },
					["@lsp.type.enumMemeber"] = { fg = "$green" },

					-- declarations
					["@attribute"] = { fg = "$fg" },
					["@variable.member"] = { fg = "$fg" },
					["@variable.builtin"] = { fg = "$fg" },
					["@variable.parameter"] = { fg = "$fg" },
					["@property"] = { fg = "$fg" },
					["@constant"] = { fg = "$fg" },
					["@constant.builtin"] = { fg = "$red" },
					["@constant.macro"] = { fg = "$fg" },
					["@module"] = { fg = "$fg" },
					["@namespace"] = { fg = "$fg" },
					["@field"] = { fg = "$fg" },

					-- literals
					["@string"] = { fg = "$red" },
					["@string.regexp"] = { fg = "$red" },
					["@string.special.symbol"] = { fg = "$fg" },
					["@string.special.url"] = { fg = "$fg" },
					["@text.literal"] = { fg = "$red" },
					["@number"] = { fg = "$red" },
					["@float"] = { fg = "$red" },
					["@number.float"] = { fg = "$red" },
					["@boolean"] = { fg = "$red" },
					["@null"] = { fg = "$red" },

					-- punctuation
					["@punctuation.bracket"] = { fg = "$fg" },
					["@punctuation.delimiter"] = { fg = "$fg" },

					-- functions
					["@method"] = { fg = "$fg" },
					["@function"] = { fg = "$fg" },
					["@function.method"] = { fg = "$fg" },
					["@function.builtin"] = { fg = "$cyan" },
					["@function.macro"] = { fg = "$fg" },
					["@attribute.typescript"] = { fg = "$fg" },
					["@constructor"] = { fg = "$fg", fmt = "none" },

					-- lsp
					["@lsp.type.method"] = { fg = "$fg" },
					["@lsp.type.property"] = { fg = "$fg" },
					["@lsp.type.parameter"] = { fg = "$fg" },
					["@lsp.typemod.method.defaultLibrary"] = { fg = "$fg" },
					["@lsp.typemod.function.defaultLibrary"] = { fg = "$cyan" },
					["@lsp.typemod.variable.defaultLibrary"] = { fg = "$fg" },
					["@lsp.typemod.string.injected"] = { fg = "$red" },

					-- cmp
					CmpItemAbbrMatch = { fg = "$white", fmt = "bold" },
					CmpItemAbbrMatchFuzzy = { fg = "$white", fmt = "bold" },
					CmpItemKindFunction = { fg = "$purple" },
					CmpItemKindConstant = { fg = "$purple" },
					CmpItemKindKey = { fg = "$purple" },

					CmpItemKindObject = { fg = "$fg" },
					ArielObject = { fg = "$fg" },
				},

				diagnostics = {
					darker = false,
					background = false,
				},
			})

			vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({})
		end,
	},
}
