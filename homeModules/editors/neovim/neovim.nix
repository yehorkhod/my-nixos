{ config, pkgs, ... }:

{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./remaps.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      vim-sleuth
      copilot-vim
      {
        plugin = rose-pine;
        config = toLuaFile ./configs/rose-pine.lua;
      }
      {
        plugin = undotree;
        config = toLuaFile ./configs/undotree.lua;
      }
      {
        plugin = mason-nvim;
        config = toLua "require('mason').setup()";
      }
      {
        plugin = mason-lspconfig-nvim;
        config = toLuaFile ./configs/mason-lspconfig.lua;
      }
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./configs/nvim-lspconfig.lua;
      }
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-nvim-lsp
      {
        plugin = nvim-cmp;
        config = toLuaFile ./configs/snippets.lua;
      }
      nvim-dap-ui
      nvim-dap-python
      nvim-nio
      {
        plugin = nvim-dap;
        config = toLuaFile ./configs/dap.lua;
      }
      {
        plugin = cloak-nvim;
        config = toLuaFile ./configs/cloak.lua;
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
        plugin = vim-fugitive;
        config = toLuaFile ./configs/fugitive.lua;
      }
      {
        plugin = gitsigns-nvim;
        config = toLuaFile ./configs/gitsigns.lua;
      }
      nvim-web-devicons
      plenary-nvim
      nui-nvim
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-python
          p.tree-sitter-bash
          p.tree-sitter-nix
          p.tree-sitter-lua
          p.tree-sitter-r
          p.tree-sitter-c
          p.tree-sitter-toml
          p.tree-sitter-json
        ]));
        config = toLua "require('nvim-treesitter.configs').setup { highlight = { enable = true } }";
      }
      
    ];
  };
}
