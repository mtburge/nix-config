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
        "browser.newtabpage.activity-stream.default.sites" = ""; # only show sites i've visited
        "browser.newtabpage.activity-stream.discoverystream.enabled" = ""; # clean newtab page
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # clean newtab page
        "browser.newtabpage.activity-stream.topSitesRows" = "2"; # two rows of sites
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # remove pocket
        "extensions.pocket.enabled" = false; # remove pocket
        "dom.event.contextmenu.enabled" = true; # i'll right click whereever i like, thank you
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
