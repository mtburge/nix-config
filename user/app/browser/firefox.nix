{ inputs, config, pkgs, nur, user, system, ... }:

{
  programs.firefox = {
    enable = true;
    
    profiles.${user.username} = {
      settings = {
        "browser.startup.page" = "0"; # always open on new tab
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # disable sponsored sites
        "browser.urlbar.suggest.quicksuggest.sponsored" = false; # don't suggest sponsored links
        #"signon.autofillForms" = false; # disable password manager
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; # dark theme
      };
      
      extensions = with config.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
      ];
    };
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
