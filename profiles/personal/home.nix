{ config, pkgs, user, system, ... }:

{
  imports = [
    ../../user/de/hyprland.nix
    ../../user/de/waybar.nix
    ../../user/de/hyprpaper.nix
    ../../user/de/theme.nix
    ../../user/de/notify.nix

    ../../user/app/browser/electron.nix
    ../../user/app/browser/firefox.nix
    ../../user/app/git/git.nix
    ../../user/app/editor/vim.nix
  ];

  home.username = user.username;
  home.homeDirectory = "/home/${user.username}";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # apps
    spotify

    # cli tools
    htop
    nix-search-cli
    tree
  ];

  programs.rofi = {
    enable = true;
  };

  home.stateVersion = "23.11";
}
