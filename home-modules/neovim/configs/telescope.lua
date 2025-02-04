local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Setup
telescope.setup()

-- Keymaps
vim.keymap.set("n", "<Space>ff", builtin.find_files)
vim.keymap.set("n", "<Space>fl", builtin.live_grep)
vim.keymap.set("n", "<Space>fg", builtin.git_files)
