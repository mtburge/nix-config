{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fira-code
    fira-code-symbols

    monaspace
    jetbrains-mono

    pkgs.nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono"]; })
    pkgs.noto-fonts-emoji

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
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
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
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Adawaita";
    };

    font = {
      #name = "JetBrainsMono Nerd Font";
      #name = "Monaspace Argon Medium";
      name = "Jetbrains Mono";
      size = 11;
    };
  };
}
