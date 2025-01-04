local dap = require('dap')
local dapui = require('dapui')
local dap_python = require('dap-python')

-- Setup
dapui.setup()

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

dap_python.setup('python')

-- Keymaps
vim.keymap.set('n', '<Space>d', function() dap.continue() end)
vim.keymap.set('n', '<Space>b', function() dap.toggle_breakpoint() end)
