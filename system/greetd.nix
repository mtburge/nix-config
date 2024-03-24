{ inputs, pkgs, user, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = initial_session;
      initial_session = {
        command = inputs.hyprland.packages.${pkgs.system}.hyprland + "/bin/Hyprland";
        user = "${user.username}";
      };
    };
  };
}
