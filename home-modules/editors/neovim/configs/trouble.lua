local trouble = require('trouble')

-- Setup
trouble.setup()

-- Keymaps
vim.keymap.set('n', '<Space>T', ':Trouble diagnostics toggle<CR>')
