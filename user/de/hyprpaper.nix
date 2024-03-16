{ config, pkgs, user, system, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.dotfiles/profiles/${system.profile}/wallpaper.jpg
    wallpaper = ,~/.dotfiles/profiles/${system.profile}/wallpaper.jpg
    splash = true
    ipc = off
  '';
}
