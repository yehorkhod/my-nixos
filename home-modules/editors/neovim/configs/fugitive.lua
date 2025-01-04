-- Keymaps
vim.keymap.set('n', '<Space>gg', function() vim.cmd("Git") end)
vim.keymap.set('n', '<Space>gc', function()
  local commit_message = vim.fn.input("Commit message: ")
  if commit_message ~= '' then
    vim.cmd('Git commit -m "' .. commit_message .. '"')
  else
    print('Commit message cannot be empty')
  end
end)
vim.keymap.set('n', '<Space>gp', function() vim.cmd("Git push") end)
