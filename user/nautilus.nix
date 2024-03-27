{ pkg, ... }:

{
  home.packages = with pkgs; [
    gnome.nautilus
  ];
}
