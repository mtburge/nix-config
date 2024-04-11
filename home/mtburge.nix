{ config, pkgs, user, system, ... }:

{
  imports = [
    # desktop environment
    ../user/desktop

    # apps
    ../user/apps/firefox.nix
    ../user/apps/electron.nix
    ../user/apps/spotify.nix
    ../user/apps/kitty.nix

    # shell
    ../user/shell/git.nix
    ../user/shell/tools.nix
    ../user/shell/fish.nix

    # editors
    ../user/editors/nvim
  ];

  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
