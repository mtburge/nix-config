{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code
    fira-code-symbols

    monaspace
    jetbrains-mono
    font-awesome

    nerdfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
    noto-fonts-emoji

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

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.sessionVariables = {
    "GTK_THEME" = "Catppuccin-Mocha-Standard-Lavender-Dark:dark";
  };

  gtk = {
    enable = true;
    
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        tweaks = [];
        variant = "mocha";
      };
      name = "Catppuccin-Mocha-Standard-Lavender-Dark";
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    iconTheme = {
      package = pkgs.reversal-icon-theme.override {
        colorVariants = [ "-black" ];
      };
      name = "Reversal-black-dark";
    };

    font = {
      name = "JetBrains Mono";
      size = 11;
    };
  };
}
