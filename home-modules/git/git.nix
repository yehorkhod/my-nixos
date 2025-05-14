{ ... }:

{
  programs.git = {
    enable = true;
    userName = "yehorkhod";
    userEmail = "e.khodysko@gmail.com";
    extraConfig = {
      pull.rebase = "false";
      tag.sort = "-taggerdate";
      credential.helper = "store";
      push.autoSetupRemote = true;
      branch.sort = "-committerdate";
      status.showUntrackedFiles = "true";
      pager.diff = "diff-so-fancy | $PAGER";
      diff-so-fancy.markEmptyLines = "false";
      commit.template = "~/.config/git/template";

      core = {
        editor = "nvim";
        preloadindex = "true";
        whitespace = "error";
      };

      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };

      color = {
        diff = {
          meta = "black bold";
          frag = "magenta";
          context = "white";
          whitespace = "yellow reverse";
          old = "red";
        };
        decorate = {
          HEAD = "red";
          branch = "blue";
          tag = "yellow";
          remoteBranch = "magenta";
        };
      };

      interactive = {
        diffFilter = "diff-so-fancy --patch";
        singlekey = "true";
      };

      log = {
        abbrevCommit = "true";
        graphColors = "blue,yellow,cyan,magenta,green,red";
      };
    };
  };
}
