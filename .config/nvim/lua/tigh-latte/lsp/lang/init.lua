local function import_dir(directory)
	local scan = vim.fn.globpath(directory, "*.lua")
	for _, file in ipairs(vim.split(scan, "\n")) do
		if file ~= "" then
			local module = file:match("([^/]+)%.lua$")
			if module and module ~= "init" then
				require("tigh-latte.lsp.lang." .. module)
			end
		end
	end
end

import_dir(vim.fn.stdpath("config") .. "/lua/tigh-latte/lsp/lang")
