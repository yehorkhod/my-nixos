local trouble = require("trouble")

-- Setup
trouble.setup()

-- Keymaps
vim.keymap.set("n", "<Space>T", function()
	vim.cmd("Trouble diagnostics toggle")
end)
