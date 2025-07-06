{ pkgs, configs, ... }:

let theme = configs.theme;
in {
  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      nil
      nixfmt-classic
      pyright
      ruff
      ghc
      haskell-language-server
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
        auto-format = true;
        formatter = {
          command = "ruff";
          args = [ "format" "--line-length" "80" "-" ];
        };
        language-servers = [ "pyright" ];
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
        "inherits" = if theme == "rose-pine" then
          "rose_pine"
        else if theme == "gruvbox-light" then
          "gruvbox_light_hard"
        else
          "everforest_dark";
        "ui.background" = { };
      };
    };
  };
}
