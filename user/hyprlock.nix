{ inputs, pkgs, user, ... }:

{
  home.packages = with inputs.hyprlock.packages.${pkgs.system}; [
    hyprlock
  ];
  
  home.file.".config/hypr/hyprlock.conf".text = ''
    general {
      grace = 0
      disable_loading_bar = true
      hide_cursor = true
      no_fade_in = true
      no_fade_out = false
      ignore_empty_input = true
    }

    background {
      monitor =
      path = ${user.wallpaper}
      blur_size = 14
      blur_passes = 1
      noise = 0.0117
    }

    label {
      monitor =
      text = cmd[update:1000] echo "<span letter_spacing='1' weight='bold'>$TIME</span>"
      color = rgba(200, 200, 200, 1)
      font_size = 96
      font_family = JetBrains Mono
      font_weight = bold
      letter_spacing = 0.5
      position = 0, -220
      halign = center
      valign = top
    }
    
    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%a %d %B")"
      color = rgba(200, 200, 200, .7)
      font_size = 24
      font_family = JetBrains Mono
      position = 0, -180
      halign = center
      valign = top
    }

    label {
      monitor =
      text = $USER
      color = rgba(200, 200, 200, .7)
      font_size = 18
      font_family = JetBrains Mono
      position = 0, 55
      halign = center
      valign = center
    }
    
    input-field {
      monitor =
      size = 250, 50
      outline_thickness = 1
      dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(30, 30, 46)
      inner_color = rgb(69, 71, 90)
      font_color = rgb(200, 200, 200)
      fade_on_empty = false
      font_family = JetBrains Mono
      fade_timeout = 500 # Milliseconds before fade_on_empty is triggered.
      placeholder_text = <span foreground="##9399b2">Password</span>
      hide_input = false
      rounding = 0.25 # -1 means complete rounding (circle/oval)
      check_color = rgb(30, 30, 46)
      fail_color = rgb(243, 139, 168)
      fail_text =
      fail_transition = 30
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off

      position = 0, 0
      halign = center
      valign = center
    }
  '';
}
