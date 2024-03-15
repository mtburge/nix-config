{ config, pkgs, user, system, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.dotfiles/workspaces/${system.workspace}/wallpaper.jpg
    wallpaper = ,~/.dotfiles/workspaces/${system.workspace}/wallpaper.jpg
    splash = true
    ipc = off
  '';
}
