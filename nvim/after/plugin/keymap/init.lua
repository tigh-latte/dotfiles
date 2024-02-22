local fn = ({
	["Darwin"] = function()
		vim.keymap.set("n", "`", "<Nop>", { silent = true, remap = false })
		vim.g.mapleader = "`"
	end,
})[vim.loop.os_uname().sysname]

if not fn then
	fn = function()
		vim.g.mapleader = "\\"
	end
end

fn()
