-- Move visual selected lines up or down.
-- Has the same effect as just deleting the text and pasting it where
-- you'd like, but is visually nicer.
-- NOTE: this spams your undo history.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set({ "n", "v" }, "n", "nzz", { silent = true })
vim.keymap.set({ "n", "v" }, "N", "Nzz", { silent = true })
vim.keymap.set("n", "<Leader>he", require("telescope.builtin").help_tags, { silent = true })
