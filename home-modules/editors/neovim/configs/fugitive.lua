-- Keymaps
vim.keymap.set('n', '<Space>gg', vim.cmd.Git)
vim.keymap.set('n', '<Space>gc', ':Git commit -m ""<Left>')
vim.keymap.set('n', '<Space>gp', ':Git push<CR>')
