return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					next = "<M-n>",
				},
			},
			filetypes = {
				lua = true,
				go = true,
				sh = true,
				python = true,
				typescript = true,
				typescriptreact = true,
				html = true,
				["typescript.tsx"] = true,
				javascript = true,
				javascriptreact = true,
				["javascript.jsx"] = true,
				["*"] = false,
			},
		})
	end,
}
