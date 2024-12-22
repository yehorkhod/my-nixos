vim.g.mapleader = ' '

-- Clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')

-- Navigation
vim.keymap.set('n', '<C-m>%', function() vim.cmd('vertical split') end)
vim.keymap.set('n', '<C-m>"', function() vim.cmd('split') end)

vim.keymap.set('n', '<C-m>h', '<C-W>h')
vim.keymap.set('n', '<C-m>j', '<C-W>j')
vim.keymap.set('n', '<C-m>k', '<C-W>k')
vim.keymap.set('n', '<C-m>l', '<C-W>l')

-- Options
vim.opt.guicursor = ''
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv('HOME') .. '/.undodir'
vim.opt.undofile = true

vim.opt.updatetime = 60

vim.opt.scrolloff = 12
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
