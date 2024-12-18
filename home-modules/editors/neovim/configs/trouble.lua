vim.g.mapleader = ' '

local trouble = require('trouble')

trouble.setup()
vim.keymap.set('n', '<leader>T', ':Trouble diagnostics<CR>')
