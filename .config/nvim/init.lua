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

-- [[ Vim Specific stuff ]]
-- Tab/space highlighting
vim.o.list = true
vim.o.listchars = "tab:· ,extends:›,precedes:‹,nbsp:·,trail:·"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Save file persistence
vim.opt.undofile = true
vim.g.swapfile = true
vim.opt.updatetime = 100

vim.o.pumheight = 20
vim.opt.scrolloff = 4

vim.opt["guicursor"] = ""
vim.api.nvim_create_user_command("Q", "q", { bang = true })

vim.opt.nrformats:append("alpha")
require("tigh-latte.local")
