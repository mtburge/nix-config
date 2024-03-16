{ config, lib, pkgs, user, system, ... }:

{
  imports = [
    ../../system/hardware/opengl.nix
    ../../system/hardware/zram.nix

    ../../system/security/firewall.nix

    ../../system/de/hyprland.nix

    ../../system/app/1password.nix
    ../../system/common.nix
  ];


  networking.hostName = "elara";

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

