require("oil").setup({
  keymaps = {
    ["cm"] = { "actions.select", mode = "n" },
  }
})

vim.keymap.set('n', 'mc', ':Oil<CR>')
