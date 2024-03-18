{ inputs, pkgs, ...}:

{
  services.logind = {
    extraConfig = "HandlePowerKey=suspend";
    lidSwitch = "hybrid-sleep";
    powerKey = "hybrid-sleep";
    powerKeyLongPress = "poweroff";
    
  };
}
