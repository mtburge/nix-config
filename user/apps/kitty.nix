{ pkgs, ...}:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    theme = "Catppuccin-Mocha";
    settings = {
      scrollback_lines = 10000;
      font_family = "JetBrains Mono";
      font_size = 12;
      modify_font = "cell_height 100%";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      background = "#181825";
    };
  };
}
