{ config, pkgs, user, system, ... }:

{
  imports = [
    ../../user/desktop-environment
    
    #../../user/dunst
    ../../user/electron
    ../../user/firefox
    ../../user/git
    #../../user/gtk
    #../../user/hyprland
    ../../user/vim
    #../../user/waybar
  
    #../../user/lang/python.nix
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
