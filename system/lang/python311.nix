{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.python311Packages.python
    pkgs.python311Packages.pip
    pkgs.python311Packages.pygobject3 
    pkgs.python311Packages.gst-python
    pkgs.python311Packages.pycairo
  ];
}
