vim.g.mapleader = ' '

local view = require("iron.view")
local iron = require("iron.core")

iron.setup({
  config = {
    scratch_repl = true,
    repl_definition = {
      sh = { command = {"bash"} },
      python = {
        command = {
          "ipython",
          "--no-autoindent",
          "-c",
          string.format("import os; os.chdir('%s')", vim.fn.expand("%:p:h")),
          "-i",
        },
        format = require("iron.fts.common").bracketed_paste_python
      }
    },
    repl_open_cmd = view.split.vertical.botright(0.5),
  },
  keymaps = {
    visual_send = "<leader>iv",  -- iron visual
    send_file = "<leader>if",  -- iron file
    send_line = "<leader>il",  -- iron line
    send_paragraph = "<leader>ip",  -- iron paragraph
    send_until_cursor = "<leader>iu",  -- iron until cursor
    cr = "<leader>i<CR>",  -- iron cr
    interrupt = "<leader>ii",  -- iron interrupt
    exit = "<leader>iq",  -- iron quit
    clear = "<leader>ic",  -- iron clear
  },
  highlight = {
    italic = true
  },
  ignore_blank_lines = true,
})

vim.keymap.set('n', '<leader>iS', ':IronRepl<CR>')  -- iron Start
vim.keymap.set('n', '<leader>iR', ':IronRestart<CR>')  -- iron Restart
vim.keymap.set('n', '<leader>iF', ':IronFocus<CR>')  -- iron Focus
vim.keymap.set('n', '<leader>iH', ':IronHide<CR>')  -- iron Hide
