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
      reload_style_on_change = true;

      modules-left = [
        "tray"
        "clock"
        "custom/seperator"
        "hyprland/workspaces"
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
      ];

      "custom/seperator" = {
        format = "<span color=\"#585b70\"> / </span>";
      };

      "hyprland/window" = {
        format = "{}";
        max-length = 75;
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = " {ipaddr}/{cidr}";
        tooltip-format-wifi = "{essid} ({signalStrength}%): {ipaddr}/{cidr}";
        tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
        on-click = "exec nm-connection-editor";
      };

      clock = {
        format = "{:<b>%H:%M</b> %a %d %b}";
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
        format = "<span color=\"#585b70\"> / </span>   {}";
        on-click = "playerctl play-pause";
        on-scroll-down = "playerctl next";
        on-scroll-up = "playerctl previous";
        max-length = 35;
      };

      cpu = {
        format = " {usage:1}%";
      };

      memory = {
        format = " {used:0.1f}GiB";
        tooltip-format = "{avail:0.1f}GiB Available";
      };
      
      temperature = {
        format = " {temperatureC}°C";
        hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
      };

      pulseaudio = {
        format = "{icon}{volume}%";
        format-bluetooth = "{icon}{volume}%";
        format-muted = " 0%";
        format-icons = {
          headphone = " ";
          default = [" " " "];
        };
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [" " " " " " " " " "];
        states = {
          warning = 30;
          critical = 15;
        };
      };
    }];

    style = ''
      * {
        font-family: "JetBrains Mono", "Line Awesome";
        font-size: 14px;
      }
      
      window#waybar { 
        background: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
      }

      #custom-seperator {
        margin: 0 10px;
      }

      .modules-left {
        margin-left: 20px;
      }

      .modules-right {
        margin-right: 20px;
      }

      #tray {
        margin-right: 18px;
      }

      tooltip {
        background: rgba(24, 24, 37, 1);
        border: none;
        padding: 10px;
        margin: 10px;
      }

      #network, #cpu, #battery, #memory, #pulseaudio, #temperature {
        margin: 0 0 0 18px;
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
