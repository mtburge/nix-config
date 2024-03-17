{ inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./binds.nix
    ./config.nix
  ];
}
