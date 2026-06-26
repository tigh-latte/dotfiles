vim.pack.add {
	gh "nvim-treesitter/nvim-treesitter",
	gh "nvim-treesitter/nvim-treesitter-context",
}

require("nvim-treesitter").install({
	"printf",
})

vim.treesitter.language.register("bash", { "zsh" })
vim.treesitter.language.register("ini", { "env" })

-- install fork of golang parser
vim.api.nvim_create_autocmd('User', {
	pattern = 'TSUpdate',
	callback = function()
		require('nvim-treesitter.parsers').go = {
			install_info = {
				url = 'https://github.com/alienvspredator/tree-sitter-go',
				revision = 'c42d459269cfd7c7723883ea06efd426217715a4',
			},
		}
	end
})

-- auto init treesitter parsers if they exist.
-- otherwise, try to install.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo.ft)
		local parser = vim.treesitter.get_parser(args.buf, lang, { error = false })
		if parser then
			vim.treesitter.highlighter.new(parser)
			return
		end

		local parsers = require("nvim-treesitter.parsers")
		if parsers[lang] ~= nil then
			require("nvim-treesitter").install { lang }
			local t = assert(vim.uv.new_timer())
			t:start(1000, 1000, vim.schedule_wrap(function()
				local p = vim.treesitter.get_parser(args.buf, lang, { error = false })
				if p then
					vim.treesitter.highlighter.new(p)
					t:stop()
				end
			end))
		end
	end
})

vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = function()
		require("treesitter-context").setup({
			max_lines = 4,
			multiline_threshold = 4,
		})
	end,
})
