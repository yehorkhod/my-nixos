vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>gg', vim.cmd.Git)
vim.keymap.set('n', '<leader>gc', ':Git commit -m ""<Left>')
vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
