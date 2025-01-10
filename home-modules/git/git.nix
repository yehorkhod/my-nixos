{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "yehorkhod";
    userEmail = "e.khodysko@gmail.com";
    aliases = {
      tree = "log --graph --abbrev-commit --decorate --format=format:'%C(#9ccfd8)%h%C(reset) - %C(#c4a7e7)%aD%C(reset) %C(#31748f)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(#e0def4)%s%C(reset) %C(#6e6a86)- %an%C(reset)'";
    };
    extraConfig = {
      credential = {
        helper = "store";
      };
      core = {
        editor = "nvim";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = "false";
      };
    };
  };
}
