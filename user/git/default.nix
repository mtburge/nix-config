{ config, pkgs, user, ... }:

{
  home.packages = [ pkgs.git ];

  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
