-- Custom leader key per OS. This was relevant when I used the mac keyboard, but isn't
-- now. Am keeping just incase OS specific stuff is needed in the future.
(setmetatable({
	Darwin = function()
		vim.g.mapleader = " "
	end,
}, {
	__index = function(_, _)
		return function() vim.g.mapleader = " " end
	end,
}))[vim.loop.os_uname().sysname]()

-- -- Set cwd to the root of a project, if any qualifier is found.
-- local root = vim.fs.root(0, { ".git" })
-- if root then
-- 	vim.fn.chdir(root)
-- end

require("tigh-latte.lazy")
