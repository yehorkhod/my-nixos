{ pkgs, configs, ... }:

let theme = configs.theme;
in {
  programs.neovim = let
    toLua = string: ''
      lua << EOF
      ${string}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./configs.lua}
    '';

    plugins = with pkgs.vimPlugins;
      let
        theme-plugin = if theme == "rose-pine" then {
          plugin = rose-pine;
          config = toLuaFile ./configs/themes/rose-pine.lua;
        } else {
          plugin = everforest;
          config = toLuaFile ./configs/themes/everforest.lua;
        };
      in [
        theme-plugin
        vim-sleuth
        luasnip
        cmp_luasnip
        friendly-snippets
        cmp-nvim-lsp
        luasnip
        nvim-dap-ui
        nvim-dap-python
        nvim-nio
        nvim-web-devicons
        plenary-nvim
        nui-nvim
        {
          plugin = copilot-vim;
          config =
            toLua "vim.g.copilot_filetypes = { ['*'] = false, python = true, }";
        }
        {
          plugin = mason-nvim;
          config = toLua "require('mason').setup()";
        }
        {
          plugin = nvim-dap;
          config = toLuaFile ./configs/dap.lua;
        }
        {
          plugin = cloak-nvim;
          config = toLuaFile ./configs/cloak.lua;
        }
        {
          plugin = undotree;
          config = toLuaFile ./configs/undotree.lua;
        }
        {
          plugin = telescope-nvim;
          config = toLuaFile ./configs/telescope.lua;
        }
        {
          plugin = trouble-nvim;
          config = toLuaFile ./configs/trouble.lua;
        }
        {
          plugin = ChatGPT-nvim;
          config = toLuaFile ./configs/chatgpt.lua;
        }
        {
          plugin = harpoon;
          config = toLuaFile ./configs/harpoon.lua;
        }
        {
          plugin = oil-nvim;
          config = toLuaFile ./configs/oil.lua;
        }
        {
          plugin = vim-fugitive;
          config = toLuaFile ./configs/fugitive.lua;
        }
        {
          plugin = gitsigns-nvim;
          config = toLuaFile ./configs/gitsigns.lua;
        }
        {
          plugin = iron-nvim;
          config = toLuaFile ./configs/iron.lua;
        }
        {
          plugin = mason-lspconfig-nvim;
          config = toLuaFile ./configs/mason-lspconfig.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./configs/nvim-lspconfig.lua;
        }
        {
          plugin = nvim-cmp;
          config = toLuaFile ./configs/snippets.lua;
        }
        {
          plugin = nvim-colorizer-lua;
          config = builtins.readFile ./configs/colorizer;
        }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-haskell
            p.tree-sitter-c
            p.tree-sitter-python
            p.tree-sitter-r
            p.tree-sitter-bash
            p.tree-sitter-css
            p.tree-sitter-toml
            p.tree-sitter-nix
            p.tree-sitter-json
            p.tree-sitter-lua
            p.tree-sitter-yaml
            p.tree-sitter-ini
          ]));
          config = toLua
            "require('nvim-treesitter.configs').setup { highlight = { enable = true } }";
        }
      ];
  };
}
