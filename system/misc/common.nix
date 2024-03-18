{ pkgs, system, user, ... }: 

{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # networking
  networking.hostName = system.hostname;

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
    vim
    neofetch
    git
    home-manager
    kitty
  ];

  programs.dconf.enable = true;


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
