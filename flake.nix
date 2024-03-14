{
	description = "Matt's config";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
	
		nixsearch.url = "github:peterldowns/nix-search-cli";

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ...} @inputs : {
		imports = [hyprland.homeManagerModules.default];

		nixosConfigurations.elara = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
			modules = [
				./nixos/configuration.nix
				
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.mtburge = import ./home/home.nix;
				}
			];
		};
	};
}
