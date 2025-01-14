local gitsigns = require("gitsigns")

-- Setup
gitsigns.setup()

-- Keymaps
vim.keymap.set("n", "<Space>gd", gitsigns.diffthis)
vim.keymap.set("n", "<Space>gb", gitsigns.blame_line)
