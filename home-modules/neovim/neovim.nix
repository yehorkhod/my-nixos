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
        theme-plugin = if theme == "everforest" then {
          plugin = everforest;
          config = toLuaFile ./configs/themes/everforest.lua;
        } else if theme == "gruvbox-light" then {
          plugin = gruvbox-nvim;
          config = toLuaFile ./configs/themes/gruvbox-light.lua;
        } else {
          plugin = rose-pine;
          config = toLuaFile ./configs/themes/rose-pine.lua;
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
            toLua "vim.g.copilot_filetypes = { ['*'] = false, }";
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
          config = builtins.readFile ./configs/colorizer.vim;
        }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-haskell
            p.tree-sitter-python
            p.tree-sitter-gleam
            p.tree-sitter-html
            p.tree-sitter-bash
            p.tree-sitter-toml
            p.tree-sitter-json
            p.tree-sitter-yaml
            p.tree-sitter-css
            p.tree-sitter-lua
            p.tree-sitter-nix
            p.tree-sitter-ini
            p.tree-sitter-cpp
            p.tree-sitter-c
            p.tree-sitter-r
          ]));
          config = toLua
            "require('nvim-treesitter.configs').setup { highlight = { enable = true } }";
        }
      ];
  };
}
