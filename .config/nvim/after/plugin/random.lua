unpack = table.unpack or unpack

---@param append boolean?
local function insert_random(append)
	---@param opts vim.api.keyset.user_command
	return function(opts)
		local t = {}
		for str in opts.args:gmatch("([^ ]+)") do
			table.insert(t, tonumber(str))
		end
		vim.api.nvim_put({ tostring(math.random(unpack(t))) }, "c", append ~= nil and append, true)
	end
end

vim.api.nvim_create_user_command("Random", insert_random(), { nargs = "*" })
vim.api.nvim_create_user_command("RandomA", insert_random(true), { nargs = "*" })
