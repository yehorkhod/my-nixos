vim.g.mapleader = ' '

local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

vim.keymap.set('n', '<leader>d', function() dap.continue() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

require("dap-python").setup('python')
