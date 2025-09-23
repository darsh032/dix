{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    asztal.url = "github:aylur/dotfiles/pre-astal";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      username = "awesome";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      packages.${system}.nvf = pkgs.neovim;

      nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./nixos-modules/default.nix
          ./system/default.nix
          ./hosts/omen/configuration.nix
        ];
      };

      homeConfigurations.main = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/main/home.nix
          ./home-manager/modules/default.nix
          inputs.spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs username system;
        };
      };

      homeConfigurations.asztal = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/asztal/home.nix
          ./home-manager/modules/default.nix
          inputs.spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs username system;
        };
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
            rustlings
            rust-analyzer
          ];
        };

        quickshell = pkgs.mkShell {
          buildInputs = with pkgs; [
            quickshell.packages.${system}.default
            kdePackages.qtdeclarative
          ];
        };
      };
    };
}
