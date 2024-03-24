{
  description = "Matt's config";

  outputs = { self, nixpkgs, home-manager, hyprland, hyprlock, hypridle, nur, ...} @ inputs:

  let
    system = {
      arch = "x86_64-linux";
      hostname = "framework13";
      profile = "personal";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
    };

    user = {
      username = "mtburge";
      name = "Matt Burgess";
      email = "hey@mtburge.com";
      wallpaper = "~/.dotfiles/wallpapers/blobs-gnome.png";
    };

    powermgmt = {
      soft_idle_seconds = "180"; # idle seconds before dimming brightness, keyboard backlight
      lock_screen_seconds = "300"; # idle seconds before locking the screen
      idle_seconds = "330"; # idle seconds before turning off display
      suspend_seconds = "1800"; # idle seconds before suspending system
    };

    pkgs = import nixpkgs {
      system = system.arch;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    imports = [
      hyprland.homeManagerModules.default
      hyprlock.homeManagerModules.default
      hypridle.homeManagerModules.default
    ];

  in {
    nixosConfigurations = {
      ${system.hostname} = nixpkgs.lib.nixosSystem {
        system = system.arch;
        modules = [
          nur.nixosModules.nur
          (./. + "/hosts" + ("/" + system.hostname) + ".nix")
        ];
        specialArgs = {
          inherit inputs pkgs system user;
        };
      };
    };

    homeConfigurations = {
      "mtburge" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nur.nixosModules.nur
          ./home/mtburge.nix
          #(./. + "/user" + ("/" + user.username) + ".nix")
        ];

        extraSpecialArgs = {
          inherit inputs system user powermgmt;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/Hyprlock";
    hypridle.url = "github:hyprwm/Hypridle";
    nixsearch.url = "github:peterldowns/nix-search-cli";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
