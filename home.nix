{
  config,
  pkgs,
  ...
}:
let
  mk-symlink = config.lib.file.mkOutOfStoreSymlink;
  list-to-attrs =
    apps: recursive:
    builtins.mapAttrs
      (name: subpath: {
        source = mk-symlink "/home/yehorkhod/System/config/${subpath}";
        recursive = recursive;
      })
      (
        builtins.listToAttrs (
          map (x: {
            name = x;
            value = x;
          }) apps
        )
      );
  xdg-rec-apps = [
    "git"
    "helix"
    "kitty"
    "nvim"
    "tmux"
    "zathura"
  ];
  xdg-non-rec-apps = [
    "btop/btop.conf"
    "btop/themes/rose_pine_moon.theme"
    "qutebrowser/config.py"
    "mimeapps.list"
    "starship.toml"
  ];
  non-rec-apps = [
    ".bashrc"
    ".bash_profile"
  ];
in
{
  home = {
    username = "yehorkhod";
    homeDirectory = "/home/yehorkhod";
    stateVersion = "24.05";
    file = list-to-attrs non-rec-apps false;
    packages = with pkgs; [
      gcc
      ripgrep
      nil
      ruff
      pyright
      typst
      tinymist
      lua-language-server
    ];
  };
  xdg.configFile = (list-to-attrs xdg-rec-apps true) // (list-to-attrs xdg-non-rec-apps false);
}
