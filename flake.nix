{
	description = "Matt's config";

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ...}:

    let
      system = {
        arch = "x86_64-linux";
        hostname = "elara";
        workspace = "personal";
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
      };

      imports = [
        hyprland.homeManagerModules.default
      ];

  in {
    nixosConfigurations = {
      elara = nixpkgs.lib.nixosSystem {
        system = system.arch;
        modules = [
          (./. + "/profiles" + ("/" + system.workspace) + "/configuration.nix")
        ];
        specialArgs = {
          inherit pkgs;
          inherit system;
          inherit user;
        };
      };
    };

	homeConfigurations = {
		mtburge = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [ (./. + "/profiles" + ("/" + system.workspace) + "/home.nix") ];
			extraSpecialArgs = {
				inherit system;
				inherit user;
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


		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
}
