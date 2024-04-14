-- Import all lua files from the current directory.
local function import_dir(opts)
	local scan = vim.fn.globpath(opts.dir, "*.lua")
	for _, file in ipairs(vim.split(scan, "\n")) do
		if file ~= "" then
			local module = file:match("([^/]+)%.lua$")
			if module and module ~= "init" then
				require("tigh-latte.lsp.lang." .. module)
			end
		end
	end
end

import_dir({
	dir = vim.fn.stdpath("config") .. "/lua/tigh-latte/lsp/lang",
})
