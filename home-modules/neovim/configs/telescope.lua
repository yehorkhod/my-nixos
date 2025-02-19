local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Setup
telescope.setup()

-- Keymaps
vim.keymap.set("n", "<Space>f", builtin.find_files)
vim.keymap.set("n", "<Space>/", builtin.live_grep)
vim.keymap.set("n", "<Space>F", builtin.git_files)
