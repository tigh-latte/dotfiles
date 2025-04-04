local wezterm = require("wezterm") --[[@as Wezterm]]
local config = wezterm.config_builder()

---@param prefix string?
local function configure(prefix)
	if prefix then prefix = prefix .. "." end
	for _, setting in pairs({
		"colours",
		"ui",
		"keys",
		"font",
		"events",
	}) do
		if prefix then setting = prefix .. setting end
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

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
	if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" then
		config.webgpu_preferred_adapter = gpu
		break
	end
end

return config
