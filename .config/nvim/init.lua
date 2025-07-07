require("tigh-latte").setup()

-- Basic text editor
vim.o.background = "dark"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.encoding = "utf-8"

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- [[ Vim Specific stuff ]]
-- Tab/space highlighting
vim.o.list = true
vim.opt.listchars = {
	tab = "· ",
	trail = "·",
	nbsp = "·",
	extends = "›",
	precedes = "‹",
}

-- Search
vim.o.ic = true
vim.o.scs = true

-- Save file persistence
vim.o.undofile = true
vim.g.swapfile = true
vim.o.ut = 100

vim.o.ph = 20
vim.o.scrolloff = 4

vim.o.guicursor = ""

vim.o.timeoutlen = 300

vim.o.signcolumn = "number"

vim.opt.nrformats:append("alpha")

vim.o.showmode = false

require("tigh-latte.local")

vim.cmd.colorscheme(os.getenv("NVIM_THEME") or "tigh")
