local wezterm = require("wezterm") --[[@as Wezterm]]

local config = wezterm.config_builder()


---@param prefix string?
local function configure(prefix)
	for _, setting in pairs({
		"colours",
		"ui",
		"keys",
		"font",
	}) do
		if prefix then setting = table.concat({ prefix, setting }, ".") end
		local ok, module = pcall(require, setting)
		if ok then module.setup(config) end
	end
end

configure()

setmetatable({
	["aarch64-apple-darwin"] = function()
		configure("apple")
	end,
	["x86_64-unknown-linux-gnu"] = function()
		configure("linux")
	end,
}, {
	__index = function(_, key)
		wezterm.log_error("unknown operating system: " .. key)
	end,
})[wezterm.target_triple]()

return config
