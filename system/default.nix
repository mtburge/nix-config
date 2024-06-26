{ lib, pkgs, system, user, ... }: 

{
  hardware.enableRedistributableFirmware = true;

  # Nix config
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  nixpkgs.hostPlatform = lib.mkDefault system.arch;

  # i18n
  time.timeZone = system.timezone;
  i18n.defaultLocale = system.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = system.locale;
    LC_IDENTIFICATION = system.locale;
    LC_MEASUREMENT = system.locale;
    LC_MONETARY = system.locale;
    LC_NAME = system.locale;
    LC_NUMERIC = system.locale;
    LC_PAPER = system.locale;
    LC_TELEPHONE = system.locale;
    LC_TIME = system.locale;
  };

  # Common packages
  environment.systemPackages = with pkgs; [
    tree
    htop
    vim
    neofetch
    git
    brightnessctl
    killall
    xdg-utils
    libdisplay-info
    libliftoff    
  ];
  
  programs.fish.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;

  services.fwupd.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  
  environment.sessionVariables = {
    EDITOR="vim";
  };
}
