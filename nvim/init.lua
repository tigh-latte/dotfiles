require("tigh-latte.lazy")

-- Basic text editor
vim.o.background = "light"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.number = true
vim.o.encoding = "utf-8"

vim.o.ai = true
vim.o.si = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.nu = true
vim.o.rnu = true

-- Vim Specific
vim.o.list = true
vim.o.listchars = "tab:· ,extends:›,precedes:‹,nbsp:·,trail:·"
vim.g.swapfile = true

vim.o.pumheight = 20
vim.opt.scrolloff = 4
vim.opt.updatetime = 100

vim.opt["guicursor"] = ""

pcall(require, "tigh-latte.override")
