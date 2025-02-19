local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Keymaps
vim.keymap.set("n", "<Space>h", mark.add_file)
vim.keymap.set("n", "<Space>m", ui.toggle_quick_menu)

for i=1,5 do
	vim.keymap.set("n", "<Space>" .. tostring(i), function() ui.nav_file(i) end)
end
