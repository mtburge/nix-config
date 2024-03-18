{ inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./binds.nix
    ./config.nix
  ];
}
