{ inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./binds.nix
    ./config.nix
  ];
}
