local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- Keymaps
vim.keymap.set('n', '<Space>h', mark.add_file)
vim.keymap.set('n', '<Space>m', ui.toggle_quick_menu)

vim.keymap.set('n', '<Space>1', function() ui.nav_file(1) end)
vim.keymap.set('n', '<Space>2', function() ui.nav_file(2) end)
vim.keymap.set('n', '<Space>3', function() ui.nav_file(3) end)
vim.keymap.set('n', '<Space>4', function() ui.nav_file(4) end)
