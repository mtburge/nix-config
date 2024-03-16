{
	description = "Matt's config";

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, nur, ...}:

    let
      system = {
        arch = "x86_64-linux";
        hostname = "elara";
        profile = "personal";
        timezone = "Europe/London";
        locale = "en_GB.UTF-8";
      };

      user = {
        username = "mtburge";
        name = "Matt Burgess";
        email = "hey@mtburge.com";
      };
      
      pkgs = import nixpkgs {
        system = system.arch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
        packageOverrides = pkgs: {
          nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
            inherit pkgs;
          };
        };
      };

      imports = [
        hyprland.homeManagerModules.default
      ];

  in {
    nixosConfigurations = {
      ${system.hostname} = nixpkgs.lib.nixosSystem {
        system = system.arch;
        modules = [
          (./. + "/machines" + ("/" + system.hostname) + ".nix")
        ];
        specialArgs = {
          inherit pkgs;
          inherit system;
          inherit user;
        };
      };
    };

	homeConfigurations = {
		${user.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        (./. + "/profiles" + ("/" + system.profile) + "/home.nix")
      ];

			extraSpecialArgs = {
        inherit inputs system user;
			};
    };
	};
  };

  inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    hyprland.url = "github:hyprwm/Hyprland";
    nixsearch.url = "github:peterldowns/nix-search-cli";

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
}
