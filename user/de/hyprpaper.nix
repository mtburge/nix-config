{ config, pkgs, user, system, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${user.wallpaper}
    wallpaper = ,${user.wallpaper}
    splash = false
    ipc = off
  '';
}
