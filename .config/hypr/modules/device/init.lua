local hostname = (function()
	local f = io.open("/etc/hostname")
	if not f then return "" end
	local hname = f:read("*l")
	f:close()
	return hname
end)()

require("modules.device._" .. hostname)
