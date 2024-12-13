local M = {}

local function assign_leader()
	local function space() vim.g.mapleader = " " end

	-- Custom leader key per OS. This was relevant when I used the mac keyboard, but isn't
	-- now. Am keeping just incase OS specific stuff is needed in the future.
	(setmetatable({
		Darwin = space,
	}, {
		__index = function(_, _) return space end,
	}))[(vim.uv or vim.loop).os_uname().sysname]()
end

function M.setup()
	assign_leader()

	-- Set cwd to the root of a project, if any qualifier is found.
	local root = vim.fs.root(0, { ".git" })
	if root then
		vim.fn.chdir(root)
	end

	require("tigh-latte.lazy").setup()
end

return M
