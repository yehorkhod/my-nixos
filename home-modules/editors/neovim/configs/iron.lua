vim.g.mapleader = ' '

local view = require("iron.view")
local iron = require("iron.core")

---------------- Setup -----------------
iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = { command = {"bash"} },
      python = {
        command = { "ipython", "--no-autoindent", "-i", },
        format = require("iron.fts.common").bracketed_paste_python
      }
    },
    repl_open_cmd = view.split.vertical.botright(0.5),
  },
  keymaps = {
    visual_send = "<leader>is",  -- iron send
    send_file = "<leader>if",  -- iron file
    send_line = "<leader>il",  -- iron line
    send_until_cursor = "<leader>iu",  -- iron until cursor
    cr = "<leader>i<CR>",  -- iron cr
    interrupt = "<leader>ii",  -- iron interrupt
    clear = "<leader>ic",  -- iron clear
  },
  highlight = { italic = true },
  ignore_blank_lines = true,
})

-------------- Functions ---------------
local repl_initialized = {}

local iron_start = function()
  file_type = vim.bo.filetype
  if not repl_initialized[file_type] then
    vim.cmd("IronRepl")
    local current_dir = vim.fn.expand("%:p:h")
    iron.send(nil, {string.format("import os; os.chdir('%s')", current_dir)})
    repl_initialized[file_type] = true
  else
    vim.cmd("IronRepl")
  end
end

local iron_restart = function()
  file_type = vim.bo.filetype
  vim.cmd("IronRestart")
  local current_dir = vim.fn.expand("%:p:h")
  iron.send(nil, {string.format("import os; os.chdir('%s')", current_dir)})
  repl_initialized[file_type] = true
end

--------------- Keymaps ----------------
vim.keymap.set('n', '<leader>iS', iron_start)  -- iron Start
vim.keymap.set('n', '<leader>iR', iron_restart)  -- iron Restart
vim.keymap.set('n', '<leader>iF', ':IronFocus<CR>')  -- iron Focus
vim.keymap.set('n', '<leader>iH', ':IronHide<CR>')  -- iron Hide
