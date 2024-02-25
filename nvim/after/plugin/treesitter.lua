require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua", "vim", "vimdoc", "query", "typescript", "python" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
})

local parsers = require("nvim-treesitter.parsers")
local ts_utils = require("nvim-treesitter.ts_utils")

local query = [[
	[
		(function_declaration
			result: [
				(parameter_list
					(parameter_declaration) @param.declaration)
				(type_identifier) @type.declaration
			] @result
		)
		(method_declaration
			result: [
				(parameter_list
					(parameter_declaration) @param.declaration)
				(type_identifier) @type.declaration
			] @result
		)
		(func_literal
			result: [
				(parameter_list
					(parameter_declaration) @param.declaration)
				(type_identifier) @type.declaration
			] @result
		)
	]
]]

local function get_return_types()
	local bufnr = vim.api.nvim_get_current_buf()

	local parser = parsers.get_parser(bufnr, "go")
	local root = parser:parse()[1]:root()

	local node_at_cursor = ts_utils.get_node_at_cursor()

	while node_at_cursor do
		local ctype = node_at_cursor:type()
		if vim.tbl_contains({
			"function_declaration",
			"method_declaration",
			"func_literal",
		}, ctype) then
			break
		end
		node_at_cursor = node_at_cursor:parent()
	end

	if not node_at_cursor then
		print("not inside a function")
		return
	end

	local q = vim.treesitter.query.parse(parser:lang(), query)

	local found = false
	local out = ""
	for id, node in q:iter_captures(root, bufnr, node_at_cursor:start(), node_at_cursor:end_()) do
		local name = q.captures[id]
		local text = vim.treesitter.get_node_text(node, bufnr)
		if name == "param1.declaration" or name == "type1.declaration" then
			out = out .. "result" .. " " .. text .. " "
		end
		if text == "error" then
			found = true
			break
		end
	end
	print(out)
	if found then
		--print("function has error return")
	else
		--print("function has no error return")
	end
end

vim.keymap.set("n", "<leader>cret", function()
	get_return_types()
end, { noremap = true, silent = true })
