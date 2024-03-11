require("tigh-latte")

-- Basic text editor
vim.o.background = ""
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.encoding = "utf-8"

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Vim Specific
vim.o.list = true
vim.o.listchars = "tab:· ,extends:›,precedes:‹,nbsp:·,trail:·"
vim.g.swapfile = true

vim.o.pumheight = 20
vim.opt.scrolloff = 4
vim.opt.updatetime = 100

vim.opt["guicursor"] = ""

pcall(require, "tigh-latte.override")
