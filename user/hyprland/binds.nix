{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";

    bind = [
      "$mod, T, exec, $terminal"
      "$mod, M, exit"
      "$mod, Q, killactive"
      "$mod, L, exec, hyprlock"
    ];
  };
}
