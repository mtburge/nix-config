{ config, pkgs, user, system, ... }:

{
  imports = [
    ../../user/dunst
    ../../user/electron
    ../../user/firefox
    ../../user/git
    ../../user/gtk
    ../../user/hyprland
    ../../user/hyprpaper
    ../../user/vim
    ../../user/waybar
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
