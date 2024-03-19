{ config, pkgs, ...}:

{
  home.packages = with pkgs; [
    gobject-introspection
    (python310.withPackages (ps: with ps; [
      pip
      pygobject3
      gst-python
    ]))
  ];
}
