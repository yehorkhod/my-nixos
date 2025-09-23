-- General options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.undodir"

vim.o.wrap = false
vim.o.scrolloff = 5
vim.o.guicursor = ""
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.foldmethod = "marker"
vim.o.winborder = "rounded"

vim.g.mapleader = " "


-- Packages
vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/Vigemus/iron.nvim" },
    { src = "https://github.com/laytan/cloak.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})


-- Colorscheme
require("rose-pine").setup({ styles = { transperency = true } })
vim.cmd.colorscheme("rose-pine-moon")
vim.cmd("hi StatusLine guibg=NONE")


-- Netrw replacement
require("oil").setup({ view_options = { show_hidden = true } })
vim.keymap.set("n", "-", ":Oil<CR>")


-- Repl
require("iron.core").setup({
    config = {
        scratch_repl = true,
        repl_definition = {
            sh = { command = { "bash" } },
            python = {
                command = { "ipython", "--no-autoindent", "-i" },
                format = require("iron.fts.common").bracketed_paste_python,
            },
        },
        repl_open_cmd = require("iron.view").split.rightbelow(0.3),
    },
    keymaps = {
        visual_send = "<leader>is",
        send_file = "<leader>if",
        send_line = "<leader>il",
        send_until_cursor = "<leader>iu",
    },
    highlight = { italic = true },
    ignore_blank_lines = true,
})
vim.keymap.set("n", "<leader>iS", ":IronRepl<CR>")
vim.keymap.set("n", "<leader>iF", ":IronFocus<CR>")
vim.keymap.set("n", "<leader>iH", ":IronHide<CR>")


-- Secrets hider
require("cloak").setup({
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    patterns = {
        { file_pattern = ".env*", cloak_pattern = "=.+", replace = nil },
    },
})


-- File picker
local pick = require("mini.pick")
pick.setup()
vim.keymap.set("n", "<leader>f", pick.builtin.files)
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live)
vim.keymap.set("n", "<leader>h", pick.builtin.help)
vim.keymap.set("n", "<leader>b", pick.builtin.buffers)


-- Git signs
local gitsigns = require("gitsigns")
gitsigns.setup()
vim.keymap.set("n", "<leader>gd", gitsigns.diffthis)
vim.keymap.set("n", "<leader>gb", gitsigns.blame_line)


-- Colorize
local old_deprecate = vim.deprecate
vim.deprecate = function() end
require("colorizer").setup()
vim.deprecate = old_deprecate


-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "json", "yaml", "toml", "ini", "xml",
        "bash", "lua", "nix", "typst",
        "cpp", "java", "r", "zig",
        "haskell", "html", "css",
        "gleam", "python", "c",
    },
    ignore_install = {},
    highlight = { enable = true },
    auto_install = true,
    sync_install = false,
})


-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt.nu = false
        vim.opt.relativenumber = false
    end,
})


-- LSP
vim.lsp.enable({ "lua_ls", "nil_ls", "pyright", "gleam", "tinymist" })
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>j", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.cmd("set completeopt+=noselect")


-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D')
vim.keymap.set({ "n", "v" }, "<leader>c", '"+c')
vim.keymap.set({ "n", "v" }, "<leader>C", '"+C')

-- Math mode
local math_mode = false
vim.keymap.set({ "n" }, "<leader>m", function()
    local file = vim.fn.expand('%:p')
    local pdf = file:gsub('%.typ$', '.pdf')

    if not math_mode then
        vim.cmd('new')
        vim.cmd('term typst watch ' .. vim.fn.fnameescape(file))
        vim.cmd('q')

        vim.cmd('new')
        vim.cmd('term zathura ' .. vim.fn.fnameescape(pdf))
        vim.cmd('q')

        math_mode = true
    else
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
                local name = vim.api.nvim_buf_get_name(buf)
                local bt = vim.bo[buf].buftype
                if bt == "terminal"
                    and (name:find("typst watch " .. vim.fn.fnameescape(file))
                        or name:find("zathura " .. vim.fn.fnameescape(pdf))) then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end
        end

        math_mode = false
    end
end)
