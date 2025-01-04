local oil = require("oil")

-- Setup
oil.setup({ view_options = { show_hidden = true } })

-- Keymaps
vim.keymap.set('n', '-', function() vim.cmd("Oil") end)
