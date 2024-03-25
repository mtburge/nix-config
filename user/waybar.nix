{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    playerctl
  ];

  home.file.".config/waybar/mediaplayer.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      player_status=$(playerctl status 2> /dev/null)
      if [ "$player_status" = "Playing" ]; then
          sed "s/&/&amp;/g" <<< "$(playerctl metadata artist) - $(playerctl metadata title)"
      elif [ "$player_status" = "Paused" ]; then
          sed "s/&/&amp;/g" <<< " $(playerctl metadata artist) - $(playerctl metadata title)"
      fi
    '';
  };

  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 40;
      spacing = 5;

      modules-left = [
        "clock"
        "hyprland/workspaces"
        #"hyprland/mode"
        #"hyprland/scratchpad"
        "custom/spotify"
      ];

      modules-center = [
        "hyprland/window"
      ];

      modules-right = [
        "network"
        "pulseaudio"
        "cpu"
        "memory"
        "temperature"
        "battery"
        "tray"
      ];

      clock = {
        format = " {:%H:%M %a %d %b} <span color=\"#585b70\"> | </span>";
        tooltip-format = "<tt><big>{calendar}</big></tt>";
        calendar = {
          mode = "month";
          mode-mon-col = 2;
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            today = "<span color='#f38ba8'><b>{}</b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_down";
          on-scroll-down = "shift_up";
        };
      };

      "custom/spotify" = {
        exec = "$HOME/.config/waybar/mediaplayer.sh";
        exec-if = "pgrep spotify";
        interval = 1;
        format = "<span color=\"#585b70\"> | </span>   {}";
        on-click = "playerctl play-pause";
        on-scroll-down = "playerctl next";
        on-scroll-up = "playerctl previous";
      };

      cpu = {
        format = "{}%";
      };

      memory = {
        format = "{}%";
      };
      
      temperature = {
        format = "{temperatureC}°C";
        hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
      };
    }];

    style = ''
      * {
        font-family: "JetBrains Mono", "Font Awesome 6 Free";
        font-size: 14px;
      }
      
      window#waybar {
        background: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
      }

      .modules-left {
        margin-left: 10px;
      }

      .modules-right {
        margin-right: 10px;
      }

      tooltip {
        background: rgba(24, 24, 37, 1);
        border: none;
        padding: 10px;
        margin: 10px;
      }

      #network, #cpu, #battery, #memory, #pulseaudio, #temperature {
        margin: 0 10px 0 0;
      }

      #cpu span {
        margin: 15px;
      }

      tooltip label {
        color: #9399b2;
      }
      
      tooltip * {
        text-shadow: none;
      }
      
      #clock {
        font-size: 15px;
        margin-right: 5px;
      }

      

      #clock tt {
        background: red;
      }

      #workspaces {
        color: inherit;
      }

      #workspaces button {
        color: inherit;
        margin: 5px 2px;
        background: none;
        border-radius: 3px;
        padding: 0 5px;
      }

      #workspaces button.active {
        font-weight: 800;
        background: rgba(166, 173, 200, 0.1);
      }

      #workspaces button:hover {
        background: rgba(166, 173, 200, 0.2);
      }

      button {
        box-shadow: none;
        border: none;
      }

      button:hover {
        background: none;
        box-shadow: none;
        text-shadow: none;
        border: none;
      }

      @keyframes blink {
          to {
            opacity: 0.25;
          }
      }

      #battery.warning:not(.charging) {
        color: #f38ba8;
        opacity: 1;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #battery.charging {
        color: #a6e3a1;
      }
    '';
  };
}
