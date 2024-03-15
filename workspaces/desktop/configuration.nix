{ config, lib, pkgs, user, system, ... }:

{
  imports =
    [
      ../../system/hardware/configuration.nix
      ../../system/hardware/opengl.nix
      ../../system/hardware/zram.nix
      
      ../../system/security/firewall.nix

      ../../system/de/hyprland.nix

      ../../system/app/1password.nix
      ../../system/common.nix
    ];

  #nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub.device = "/dev/nvme0n1p1";

  networking.hostName = "elara";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  #time.timeZone = "Europe/London";

  # Select internationalisation properties.
 #i18n.defaultLocale = "en_GB.UTF-8";
 #console = {};

  # Enable the X11 windowing system.
  #services.xserver.xkb.layout = "gb";
  #services.xserver.xkb.variant = "mac";
  #services.xserver.xkb.options = "caps:escape";
  #services.xserver.displayManager.gdm = {
#	enable = true;
#	wayland = true;
#  };

  #services.xserver.displayManager.gdm.enable = false;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.wayland.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;


  users.groups.${user.username} = {};
  users.users.${user.username} = {
    isNormalUser = true;
    group = user.username;
    extraGroups = [ "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [];
    #vim
    #kitty
    #neofetch
    #git

  #home-manager
	
  #_1password
  #_1password-gui
  #cliphist 

#programs._1password = {
#	enable = true;
#};

#programs._1password-gui = {
#	enable = true;
#	polkitPolicyOwners = ["mtburge"];
#};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  #environment.sessionVariables = {
  #	EDITOR="vim";
  #};

  #zramSwap.enable = true;

  #programs.hyprland = {
  #	enable = true;
  #	xwayland.enable = true;
  #};
}

