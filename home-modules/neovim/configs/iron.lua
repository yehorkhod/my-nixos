local view = require("iron.view")
local iron = require("iron.core")
local file_types_common = require("iron.fts.common")

-- Setup
iron.setup({
	config = {
		scratch_repl = true,
		repl_definition = {
			sh = { command = { "bash" } },
			python = {
				command = { "ipython", "--no-autoindent", "-i" },
				format = file_types_common.bracketed_paste_python,
			},
		},
		repl_open_cmd = view.split.rightbelow(0.3),
	},
	keymaps = {
		visual_send = "<Space>is", -- iron send
		send_file = "<Space>if", -- iron file
		send_line = "<Space>il", -- iron line
		send_until_cursor = "<Space>iu", -- iron until cursor
	},
	highlight = { italic = true },
	ignore_blank_lines = true,
})

-- Keymaps
vim.keymap.set("n", "<Space>iS", function()
	vim.cmd("IronRepl")
end)
vim.keymap.set("n", "<Space>iF", function()
	vim.cmd("IronFocus")
end)
vim.keymap.set("n", "<Space>iH", function()
	vim.cmd("IronHide")
end)
