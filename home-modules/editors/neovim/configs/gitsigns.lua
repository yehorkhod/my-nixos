vim.g.mapleader = ' '

local gitsigns = require('gitsigns')
gitsigns.setup()
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis)
vim.keymap.set('n', '<leader>gb', gitsigns.blame_line)
