local mason_lspconfig = require("mason-lspconfig")

-- Setup
mason_lspconfig.setup({
	ensure_installed = { "pyright" },
})
