{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
  ];

  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = "32x32";
    };

    settings = {
      global = {
        # size and position
        monitor = 0;
        follow = "mouse";
        width = "(0, 500)";
        height = 300;
        origin = "bottom-center";
        offset = "0x50";
        scale = 0;
        notification_limit = 6;

        # progress bar
        progress_bar = true;
        progress_bar_height = 18;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 360;
        progress_bar_max_width = 360;
        progress_bar_corners = "all";
        progress_bar_corner_radius = 5;

        # styling
        timeout = 5;
        padding = 16;
        separator_height = 5;
        horizontal_padding = 16;
        frame_width = 0;
        gap_size = 2;
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrains Mono 11";
        line_height = 4;
        alignment = "left";
        vertical_alignment = "top";
        show_age_threshold = 60;
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = true;
        corner_radius = 5;

        # formatting
        markup = "full";
        format = "<b>%s</b>\n<small>%b</small>%p\n%a";
        ellipsize = "middle";

        # icons
        icon_theme = "Adwaita";
        icon_corner_radius = 5;
        min_icon_size = 24;
        max_icon_size = 42;
        text_icon_padding = 14;
      
        # colours
        background = "#313244";
        foreground = "#bac2de";
        frame_color = "#45475a";
        highlight = "#cba6f7";
      };

      urgency_critical = {
        background = "#f38ba8";
        foreground = "#181825";
        frame_color = "#ff5555";
        timeout = 0;
      };
    };
  };
}
