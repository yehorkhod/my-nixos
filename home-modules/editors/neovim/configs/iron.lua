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
		repl_open_cmd = view.split.vertical.botright(0.5),
	},
	keymaps = {
		visual_send = "<Space>is", -- iron send
		send_file = "<Space>if", -- iron file
		send_line = "<Space>il", -- iron line
		send_until_cursor = "<Space>iu", -- iron until cursor
		cr = "<Space>i<CR>", -- iron cr
		interrupt = "<Space>ii", -- iron interrupt
		clear = "<Space>ic", -- iron clear
	},
	highlight = { italic = true },
	ignore_blank_lines = true,
})

-- Functions
local repl_initialized = {}

local iron_start = function()
	local file_type = vim.bo.filetype
	if not repl_initialized[file_type] then
		vim.cmd("IronRepl")
		local current_dir = vim.fn.expand("%:p:h")
		iron.send(nil, { string.format("import os; os.chdir('%s')", current_dir) })
		repl_initialized[file_type] = true
	else
		vim.cmd("IronRepl")
	end
end

local iron_restart = function()
	local file_type = vim.bo.filetype
	vim.cmd("IronRestart")
	local current_dir = vim.fn.expand("%:p:h")
	iron.send(nil, { string.format("import os; os.chdir('%s')", current_dir) })
	repl_initialized[file_type] = true
end

-- Keymaps
vim.keymap.set("n", "<Space>iS", iron_start) -- iron Start
vim.keymap.set("n", "<Space>iR", iron_restart) -- iron Restart
vim.keymap.set("n", "<Space>iF", function()
	vim.cmd("IronFocus")
end) -- iron Focus
vim.keymap.set("n", "<Space>iH", function()
	vim.cmd("IronHide")
end) -- iron Hide
