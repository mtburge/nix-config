{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1,prefered,auto,1.175000"
        "DP-3,prefered,-2256x-768,auto"
        ",prefered,auto,auto"
        
      ];

      env = [
        "XCURSOR_SIZE,24"
        "GDK_SCALE,1.5"
        "GDK_DPI_SCALE=,1.5"
      ];

      misc = {
        key_press_enables_dpms = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      exec-once = [
        "hypridle"
        "dunst"
        "waybar"
        "1password --silent"
        "hyprpaper"
        "blueman-applet &"
        "walker --gapplication-service"
      ];

      input = {
        kb_layout = "gb";
        kb_variant = "mac";
        kb_options = "caps:escape";
        follow_mouse = 1;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      general = {
        gaps_in = 8;
        gaps_out = 32;
        border_size = 2;
        allow_tearing = false;
        "col.active_border" = "0xFF7f849c";
        "col.inactive_border" = "0xFF313244";
      };

      gestures = {
        workspace_swipe = "on";
      };

      decoration = {
        rounding = 10;
        drop_shadow = false;

        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      "$mod" = "SUPER";

      bind = [
        # global shortcuts
        "$mod, T, exec, kitty"
        "$mod, M, exit"
        "$mod, Q, killactive"
        "$mod, L, exec, hyprlock"
        "$mod, F, fullscreen"
        "$mod, Space, exec, walker"
        "$mod, B, exec, xdg-open about:home"

        # switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, Tab, workspace, e+1"
        "$mod SHIFT, Tab, workspace, e-1"

        # move window to workspace
        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"
        "$mod SHIFT, 6, movetoworkspacesilent, 6"
        "$mod SHIFT, 7, movetoworkspacesilent, 7"
        "$mod SHIFT, 8, movetoworkspacesilent, 8"
        "$mod SHIFT, 9, movetoworkspacesilent, 9"

        # select window
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # move window position
        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, up, movewindow, u"
        "$mod CTRL, down, movewindow, d"

        # xf86 keys
        ", xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", xf86audioplay, exec, playerctl play-pause" 
        ", xf86audionext, exec, playerctl next" 
        ", xf86audioprev, exec, playerctl previous" 
        ", xf86monbrightnessup, exec, brightnessctl set 10%+" 
        ", xf86monbrightnessdown, exec, brightnessctl set 10%-" 
      ];

      binde = [
        "$mod SHIFT, left, resizeactive, -100 0"
        "$mod SHIFT, right, resizeactive, 100 0"
        "$mod SHIFT, up, resizeactive, 0 -100"
        "$mod SHIFT, down, resizeactive, 0 100"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        ",switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1,prefered,auto,1.175000\""
        ",switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1,disable\""
      ];

      windowrulev2 = [
        "float,class:(pavucontrol)"
        "size 600 500,class:(pavucontrol)"
        "move onscreen 100%-610 50,class:(pavucontrol)"
      
        "float,class:(nm-connection-editor)"
        "move onscreen 100%-610 50,class:(nm-connection-editor)"
      
        "float,class:(blueman-manager)"
        "move onscreen 100%-610 50,class:(blueman-manager)"
      ];
    };
  };
}
