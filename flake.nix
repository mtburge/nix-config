{
  description = "Matt's config";

  outputs = { self, nixpkgs, home-manager, hyprland, hyprlock, hypridle, nur, unstable, walker, hyprland-contrib, ...} @inputs:
  
  let
    system = {
      arch = "x86_64-linux";
      hostname = "framework13";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
    };

    user = {
      username = "mtburge";
      name = "Matt Burgess";
      email = "hey@mtb.dev";
      wallpaper = "~/.dotfiles/user/wallpapers/blobs-gnome.png";
    };

    powermgmt = {
      soft_idle_seconds = "180"; # idle seconds before dimming monitor brightness
      lock_screen_seconds = "300"; # idle seconds before locking the screen
      suspend_seconds = "330"; # idle seconds before suspending system
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
        ];

        extraSpecialArgs = {
          inherit inputs system user powermgmt;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/Hyprlock";
    hypridle.url = "github:hyprwm/Hypridle";
    nixsearch.url = "github:peterldowns/nix-search-cli";
    nur.url = "github:nix-community/NUR";
    walker.url = "github:abenz1267/walker";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";  
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
