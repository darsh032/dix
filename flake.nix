{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "awesome";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    packages.${system}.default = (inputs.nvf.lib.neovimConfiguration {
	pkgs = nixpkgs.legacyPackages.${system};
	modules = [ ./nvim/nvf.nix ];
    }).neovim;

    nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs username;};
      modules = [
        ./hosts/omen/configuration.nix
      ];
    };

    homeConfigurations.main = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/main/home.nix

      ];
      extraSpecialArgs = {
        inherit inputs username;
      };
    };
  };
}
