{ lib, system, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking.hostName = system.hostname;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  hardware.wirelessRegulatoryDatabase = true;
}
