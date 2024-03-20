local M = {}

local function import_dir(opts)
	local scan = vim.fn.globpath(opts.dir, "*.lua")
	for _, file in ipairs(vim.split(scan, "\n")) do
		if file ~= "" then
			local module = file:match("([^/]+)%.lua$")
			if module and module ~= "init" then
				local lang = require("tigh-latte.lsp.lang." .. module)
				pcall(function() lang.setup({ group = opts.group }) end)
			end
		end
	end
end

M.setup = function(opts)
	import_dir({
		dir = vim.fn.stdpath("config") .. "/lua/tigh-latte/lsp/lang",
		group = opts.group,
	})
end

return M
