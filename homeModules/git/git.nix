{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "yehorkhod";
    userEmail = "e.khodysko@gmail.com";
    aliases = {
      tree = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
    };
    extraConfig = {
      credential = {
        helper = "store";
      };
      core = {
        editor = "nvim";
      };
      rerere = {
        enabled = true;
      };
    };
  };
}
