{ inputs, config, pkgs, powermgmt, ... }:

{
  home.packages = with inputs.hypridle.packages.${pkgs.system}; [
    hypridle
  ];
  
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock # avoid multiple lock instances
      before_sleep_cmd = loginctl lock-session # lock before suspend
      after_sleep_cmd = hyprctl dispatch dpms on # avoid double key press to turn on monitor
    }

    # dim display brightness
    listener {
      timeout = ${powermgmt.soft_idle_seconds}
      on-timeout = brightnessctl -s set 10
      on-resume = brightnessctl -r
    }

    # lock screen
    listener {
      timeout = ${powermgmt.lock_screen_seconds}
      on-timeout = loginctl lock-session
    }
    
    # suspend
    listener {
      timeout = ${powermgmt.suspend_seconds}
      on-timeout = systemctl suspend-then-hibernate
    }
  '';
}
