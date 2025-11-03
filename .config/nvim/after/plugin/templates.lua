local group = vim.api.nvim_create_augroup("tigh-latte-bufenter", { clear = true })

-- golang
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.go",
	group = group,
	callback = function(ev)
		local fname = vim.fs.basename(ev.file)
		local tmpl = vim.fs.joinpath(vim.fn.stdpath("config"), "/templates", fname) .. ".tmpl"
		if not vim.uv.fs_stat(tmpl) then return end

		vim.cmd("0r " .. tmpl)
		vim.bo.modified = true
	end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*_test.go",
	group = group,
	callback = function(ev)
		local alt_name = ev.file:gsub("_test.go$", ".go")
		if not vim.uv.fs_stat(alt_name) then return end

		local bufnr = vim.fn.bufadd(alt_name)
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			vim.fn.bufload(bufnr)
		end

		local pkgname = (function()
			local root = vim.treesitter.get_parser(bufnr):parse()[1]:root()
			local _, node = vim.treesitter.query.parse(
				"go", [[ (package_clause (package_identifier) @__ident) ]]
			):iter_captures(root, bufnr)()
			local line, char, eline, echar = node:range()
			return vim.api.nvim_buf_get_text(bufnr, line, char, eline, echar, {})[1]
		end)()

		vim.api.nvim_set_current_line("package " .. pkgname .. "_test")
		vim.bo.modified = true
	end,
})
