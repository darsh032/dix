{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  in
  {
    nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/omen/configuration.nix
      ];
    };

    homeConfigurations.daily = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ 
        ./home-manager/daily/home.nix 
      ];
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
