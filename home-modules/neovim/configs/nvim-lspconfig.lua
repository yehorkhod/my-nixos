local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.gleam.setup({ capabilities = capabilities })

-- Keymaps
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<Space>r", function()
	local new_name = vim.fn.input("New name: ")
	if new_name ~= "" then
		vim.lsp.buf.rename(new_name)
	else
		print("New name cannot be empty!")
	end
end)
