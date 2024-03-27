{ inputs, pkgs, ...}:

# ref: https://gist.github.com/mattdenner/befcf099f5cfcc06ea04dcdd4969a221

let hibernateEnvironment = {
    HIBERNATE_SECONDS = "900";
    HIBERNATE_LOCK = "/var/run/autohubernate.lock";
  };

in {
  environment.systemPackages = with pkgs; [
    powertop
  ];

  services.power-profiles-daemon.enable = true;

  services.logind = {
    extraConfig = ''
      HandleLidSwitch=ignore
    '';
    lidSwitch = "suspend";
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";    
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  
  systemd.sleep.extraConfig = ''
    [Sleep]
    HibernateMode=shutdown
  '';

  systemd.services."awake-after-suspend-for-a-time" = {
    description = "Sets up the suspend so that it'll wake for hibernation only if not on AC power";
    wantedBy = [ "suspend.target" ];
    before = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      if [ $(cat /sys/class/power_supply/ACAD/online) -eq 0 ]; then
        curtime=$(date +%s)
        echo "$curtime $1" >> /tmp/autohibernate.log
        echo "$curtime" > $HIBERNATE_LOCK
        ${pkgs.utillinux}/bin/rtcwake -m no -s $HIBERNATE_SECONDS
      else
        echo "System is on AC power, skipping wake-up scheduling for hibernation." >> /tmp/autohibernate.log
      fi
    '';
    serviceConfig.Type = "simple";
  };

  systemd.services."hibernate-after-recovery" = {
    description = "Hibernates after a suspend recovery due to timeout";
    wantedBy = [ "suspend.target" ];
    after = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      curtime=$(date +%s)
      sustime=$(cat $HIBERNATE_LOCK)
      rm $HIBERNATE_LOCK
      if [ $(($curtime - $sustime)) -ge $HIBERNATE_SECONDS ] ; then
        systemctl hibernate
      else
        ${pkgs.utillinux}/bin/rtcwake -m no -s 1
      fi
    '';
    serviceConfig.Type = "simple";
  };

}
