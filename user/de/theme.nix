{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    #pkgs.fantasque-sans-mono
    pkgs.fira-code
    pkgs.fira-code-symbols
    qt5.qtwayland
    qt6.qtwayland
  ];

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Reminx-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adawaita";
    };

    #font = {
    #  name = "Monospace";
    #  size = 11;
    #};
  };
}
