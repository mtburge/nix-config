{ inputs, pkgs, ...}:

{
  services.power-profiles-daemon.enable = true;

  services.logind = {
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=15m
      HandleLidSwitch=ignore
    '';
    lidSwitch = "suspend-then-hibernate";
    powerKey = "suspend-then-hibernate";
    powerKeyLongPress = "poweroff";    
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  # suspend-then-hibernate
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1h
  '';

  services.acpid = {
    enable = true;
    lidEventCommands = ''
      export PATH=$PATH:/run/current-system/sw/bin

      lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
      if [ $lid_state = "closed" ]; then
        # Set brightness to zero
        echo 0  > /sys/class/backlight/amdgpu_bl0/brightness  
      else
        # Reset the brightness
        echo 100  > /sys/class/backlight/amdgpu_bl0/brightness
      fi
    '';
  };
}
