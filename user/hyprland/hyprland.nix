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
}
