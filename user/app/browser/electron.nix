{ config, pkgs, ... }:

{
  home.file.".config/electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
	'';
}
