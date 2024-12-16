vim.ui.open = (function(fn) ---@param fn fun(string)
	return function(path) ---@param path string
		if vim.bo.ft ~= "lua" then
			return fn(path)
		end

		local cur_file = vim.uri_from_bufnr(0)
		if not cur_file:match("^.*tigh%-latte/plugins/.*%.lua$") then
			return fn(path)
		end

		local node = vim.treesitter.get_node()
		if node == nil or node:type() ~= "string_content" then
			return fn(path)
		end

		---@param n TSNode
		---@param ... string[]
		---@return boolean
		local function hierarchy(n, ...)
			for _, parent in ipairs({ ... }) do
				local c = n:parent()
				if c == nil or c:type() ~= parent then
					return false
				end
				n = c
			end
			return true
		end

		if not hierarchy(node, "string", "field", "table_constructor") then
			return fn(path)
		end

		return fn("https://github.com/" .. path)
	end
end)(vim.ui.open)
