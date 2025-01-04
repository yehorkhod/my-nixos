local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })

-- Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
