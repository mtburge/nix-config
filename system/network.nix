{ lib, system, ... }:

{
  networking.hostName = system.hostname;
  networking.useDHCP = lib.mkDefault true;
  
  networking.firewall.enable = true;
}
