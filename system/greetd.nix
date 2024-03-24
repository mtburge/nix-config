{ inputs, pkgs, user, ... }:

let session = inputs.hyprland.packages.${pkgs.system}.hyprland + "/bin/Hyprland";

in {
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${user.username}";
      };

      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting '' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };
}
