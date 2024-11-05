vim.g.mapleader = ' '

require('telescope').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fl', builtin.live_grep)
vim.keymap.set('n', '<leader>fg', builtin.git_files)
