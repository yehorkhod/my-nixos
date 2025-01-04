vim.g.mapleader = ' '

-- Clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')

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

-- Terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt.nu = false
    vim.opt.relativenumber = false
  end
})
