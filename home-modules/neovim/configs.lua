-- Clipboard
vim.keymap.set({ "n", "v" }, "<Space>y", '"+y')
vim.keymap.set({ "n", "v" }, "<Space>p", '"+p')
vim.keymap.set({ "n", "v" }, "<Space>x", '"+x')

-- Options
vim.opt.guicursor = ""
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
vim.opt.undofile = true

vim.opt.updatetime = 60

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt.nu = false
		vim.opt.relativenumber = false
	end,
})

-- Latex
-- Keybinding to compile the current file with xelatex
local zathura_launched = false

vim.keymap.set('n', '<Space>l', function()
  vim.cmd("w")
  local file = vim.fn.expand('%:p') -- Get the full path of the current file
  if file == "" then
    print("No file to compile!")
    return
  end

  local pdf_file = vim.fn.expand('%:r') .. ".pdf" -- Get the PDF file path
  local cmd = "xelatex " .. file
  print("Running: " .. cmd)
  vim.fn.system(cmd)

  -- Check for compilation errors
  if vim.v.shell_error ~= 0 then
    print("Compilation failed! Check the output.")
  else
    print("Compilation successful!")

    if zathura_launched == false then
      -- Open Zathura with the generated PDF
      local open_cmd = "zathura " .. pdf_file .. " &"
      os.execute(open_cmd)
      print("Opened PDF in Zathura!")
      zathura_launched = true
    end
  end
end)
