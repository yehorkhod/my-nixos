vim.g.mapleader = ' '

local trouble = require('trouble')

vim.keymap.set('n', '<leader>T', function()
  trouble.toggle()
end)
