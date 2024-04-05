{ config, pkgs, user, ... }:

{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;
    extraConfig = {
      init.defaultBranch = "main";
      core.excludesfile= "~/.gitignore_global";

      alias = {
        # quick status
        "s" = "status -s";

        # pretty log for recent commits
        "l" = "log --pretty=oneline -n 20 --graph --abbrev-commit";

        # contributors
        "contrib" = "shortlog --summary --numbered";
      };
    };
  };

  home.file.".gitignore_global".text = ''
    *.swp
  '';
}
