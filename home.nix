# FIX: btop && qutebrowser
{ config, pkgs, ... }:

let
  list-to-attrs =
    apps: recursive:
    builtins.mapAttrs
      (name: subpath: {
        source = config.lib.file.mkOutOfStoreSymlink ./config/${subpath};
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
  rec-apps = [
    "btop"
    "git"
    "helix"
    "kitty"
    "nvim"
    "qutebrowser"
    "tmux"
    "zathura"
  ];
  non-rec-apps = [
    "mimeapps.list"
    "starship.toml"
  ];
in
{
  home = {
    username = "yehorkhod";
    homeDirectory = "/home/yehorkhod";
    stateVersion = "24.05";
    file = {
      ".bashrc".source = ./config/.bashrc;
      ".bash_profile".source = ./config/.bash_profile;
    };
  };
  xdg.configFile = (list-to-attrs rec-apps true) // (list-to-attrs non-rec-apps false);
}
