{ config, pkgs, user, ... }:


{
  programs.firefox = {
    enable = true;
    profiles.${user.username} = {
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    };
  };
}
