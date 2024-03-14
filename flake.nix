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
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ...} : {
		imports = [hyprland.homeManagerModules.default];

		nixosConfigurations.elara = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
			modules = [
				./hosts/elara/configuration.nix
				
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.mtburge = import ./home/home.nix;
				}
			];
		};
	};
}
