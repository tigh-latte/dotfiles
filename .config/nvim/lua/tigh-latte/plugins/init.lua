return {
	setup = function()
		---Install a plugin
		---@param ... string|vim.pack.Spec
		_G.install = function(...)
			vim.pack.add({ ... }, { load = false })
		end

		---Prefix a string with https://github.com/
		---@param s string plugin handle
		---@return string the prepended string
		_G.gh = function(s)
			return "https://github.com/" .. s
		end

		local plugin_dir = vim.fn.stdpath("config") .. "/lua/tigh-latte/plugins/"

		local scan = vim.fn.globpath(plugin_dir, "*.lua")
		for _, file in ipairs(vim.split(scan, "\n")) do
			if file ~= "" and file ~= "init.lua" then
				local plugin = file:match("([^/]+)%.lua$")
				require("tigh-latte.plugins." .. plugin)
			end
		end
	end,
}
