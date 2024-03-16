{ inputs, config, pkgs, user, system, ... }:

{
  programs.firefox = {
    enable = true;
    
    profiles.${user.username} = {
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
      
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
      ];
    };
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
