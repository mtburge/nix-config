{ ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = ",prefered,auto,auto";

      env = [
        "XCURSOR_SIZE,24"
        "GDK_SCALE,1.5"
        "GDK_DPI_SCALE=,1.5"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      exec-once = [
        "hypridle"
        "dunst"
        "waybar"
        "1password --silent"
        "hyprpaper"
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

        blur = {
          enabled = true;
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
    };
  };
}
