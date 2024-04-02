{ inputs, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    powertop
  ];

  services.power-profiles-daemon.enable = true;

  # Define power switch behaviours
  services.logind = {
    extraConfig = ''
      HandleLidSwitch=ignore
    '';
    lidSwitch = "suspend-then-hibernate";
    powerKey = "suspend-then-hibernate";
    powerKeyLongPress = "poweroff";    
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  
  systemd.sleep.extraConfig = ''
    [Sleep]
    HibernateMode=shutdown
    HibernateDelaySec=1h
  '';

  # Setup power modes based on AC status
  services.udev.extraRules = ''
    # allow keyboard to wake from suspend
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="enabled"

    # switch to balanced performance when plugged in
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"

    # switch to power-saver whilst on battery
    SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
  '';
}
