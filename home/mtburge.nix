{ config, pkgs, user, system, ... }:

{
  imports = [
    ../user/electron.nix
    ../user/firefox.nix
    ../user/git.nix
    ../user/dunst.nix
    ../user/gtk.nix
    ../user/hypridle.nix
    ../user/hyprland.nix
    ../user/hyprlock.nix
    ../user/hyprpaper.nix
    ../user/waybar.nix
    ../user/vim.nix
    ../user/walker.nix
    
    ../user/nautilus.nix
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

  home.stateVersion = "23.11";
}
