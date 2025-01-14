{ pkgs, configs, ... }:

let theme = configs.theme;
in {
  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      nil
      nixfmt-classic
      (python3.withPackages (p: (with p; [ python-lsp-server ])))
      haskell-language-server
      ghc
      stylish-haskell
    ];

    settings = {
      theme = "custom_theme";
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
        name = "python";
        language-servers = [ "pylsp" ];
      }
      {
        name = "haskell";
        auto-format = true;
        formatter.command = "stylish-haskell";
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
