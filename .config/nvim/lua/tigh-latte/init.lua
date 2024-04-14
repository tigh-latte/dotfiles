-- Custom leader key per OS. This was relevant when I used the mac keyboard, but isn't
-- now. Am keeping just incase OS specific stuff is needed in the future.
local fn = ({
	["Darwin"] = function()
		vim.keymap.set("n", "`", "<Nop>", { silent = true, remap = false })
		vim.g.mapleader = "`"
	end,
})[vim.loop.os_uname().sysname]

if not fn then
	fn = function()
		vim.g.mapleader = " "
	end
end

fn()

require("tigh-latte.lazy")
