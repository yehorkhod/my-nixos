-- Viewer method
vim.g.vimtex_view_method = 'zathura'

-- Latex compiler
vim.g.vimtex_compiler_method = 'latexmk'

-- Keymaps
vim.keymap.set('n', '<Space>l', function() vim.cmd('VimtexCompile') end)
