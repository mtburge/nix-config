{ config, pkgs, user, system, ... }:

{
  imports = [
    # desktop environment
    ../user/desktop

    # apps
    ../user/apps/firefox.nix
    ../user/apps/electron.nix
    ../user/apps/spotify.nix

    # shell
    ../user/shell/git.nix
    ../user/shell/tools.nix

    # editors
    ../user/editors/vim.nix
  ];

  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
