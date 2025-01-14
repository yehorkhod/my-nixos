{ pkgs, configs, ... }:

let theme = configs.theme;
in {
  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      # Lua
      lua-language-server
      # Nix
      nil
      nixfmt-classic
      # Python
      (python3.withPackages
        (p: (with p; [ ruff python-lsp-ruff python-lsp-server ])))
      # Haskell
      haskell-language-server
      ghc
    ];

    settings = {
      theme = "custom_theme";
      keys.insert = { "C-[" = "normal_mode"; };
      editor = {
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "block";
          select = "block";
        };
        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt";
        language-servers = [ "nil" ];
      }
      {
        name = "lua";
        language-servers = [ "lua-language-server" ];
      }
      {
        name = "python";
        language-servers = [ "pylsp" ];
      }
      {
        name = "haskell";
        language-servers = [ "haskell-language-server" ];
      }
    ];

    themes = {
      custom_theme = {
        "inherits" =
          if theme == "rose-pine" then "rose_pine" else "everforest_dark";
        "ui.background" = { };
      };
    };
  };
}
