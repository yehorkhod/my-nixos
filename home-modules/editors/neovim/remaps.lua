vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>l', vim.cmd.Ex)

vim.keymap.set('n', '<C-m>%', function() vim.cmd('vertical split') end)
vim.keymap.set('n', '<C-m>"', function() vim.cmd('split') end)

vim.keymap.set('n', '<C-m>h', '<C-W>h')
vim.keymap.set('n', '<C-m>j', '<C-W>j')
vim.keymap.set('n', '<C-m>k', '<C-W>k')
vim.keymap.set('n', '<C-m>l', '<C-W>l')
