{ pkgs, ...}:

{
  home.packages = with pkgs; [
    loupe # image viewer
    vlc # media player
    gnome.nautilus # file manager
  ];
}
