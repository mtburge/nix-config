{ inputs, pkgs, ... }:

{
  home.packages = with inputs.hyprlock.packages.${pkgs.system}; [
    hyprlock
  ];
  
  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ~/.dotfiles/wallpapers/skipping-stones.png
      blur_size = 7
      blur_passes = 1
      noise = 0.0117
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 3
      dots_size = 0.20 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(30, 30, 46)
      inner_color = rgb(88, 91, 112)
      font_color = rgb(200, 200, 200)
      fade_on_empty = false
      fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
      placeholder_text =
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off

      position = 0, 10
      halign = center
      valign = center
    }

    label {
      monitor =
      text = $USER
      color = rgba(200, 200, 200, 1.0)
      font_size = 25
      font_family = Noto Sans

      position = 0, 80
      halign = center
      valign = center
    }
  '';
}
