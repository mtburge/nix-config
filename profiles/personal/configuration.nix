{ config, lib, pkgs, user, system, ... }:

{
  imports = [
    ../../system/hardware/opengl.nix
    ../../system/hardware/swap.nix
    ../../system/hardware/media.nix
    ../../system/hardware/power.nix

    ../../system/security/firewall.nix
    ../../system/security/polkit.nix
    ../../system/security/greetd.nix

    ../../system/misc/common.nix
    ../../system/apps/1password.nix
  
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.groups.${user.username} = {};
  users.users.${user.username} = {
    isNormalUser = true;
    group = user.username;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [];

  networking.firewall.allowedTCPPorts = [
    57621 #spotify
  ];
  
  networking.firewall.allowedUDPPorts = [
    5353 #spotify
  ];

  system.stateVersion = "23.11";
}

