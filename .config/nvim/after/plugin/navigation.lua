-- Simple split window navigation.
vim.keymap.set({ "n", "v" }, "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })

-- Use , and . to change the indection within the current set of { }
vim.keymap.set({ "n", "v" }, "<Leader>,", "<i}", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>.", ">i}", { noremap = true })

-- After paging the window forward or backward, recentre the screen on the cursor.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Make <Esc> easier to reach on a macbook.
vim.keymap.set({ "i", "v" }, "§", "<Esc>", { noremap = true })
