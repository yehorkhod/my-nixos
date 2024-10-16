vim.g.mapleader = ' '

require("chatgpt").setup({
  openai_params = {
    model = 'gpt-4o-mini',
    max_tokens = 4095,
    temperature = 0.2
  },
  vim.keymap.set('n', '<leader>C', vim.cmd.ChatGPT)
})
