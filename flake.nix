{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    wrappers.url = "github:lassulus/wrappers";

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
      wrappers,
      ...
    }@inputs:
    let
      username = "awesome";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      helix-regular = import ./wrappers/helix/helix-regular.nix {
        inherit pkgs wrappers;
      };

      helix-python = import ./wrappers/helix/helix-python.nix {
        inherit pkgs wrappers;
      };

      helix-rust = import ./wrappers/helix/helix-rust.nix {
        inherit pkgs wrappers;
      };
    in
    {
      packages = {
        ${system} = {
          hx-regular = helix-regular;
          hx-python = helix-python;
          hx-rust = helix-rust;
        };
      };
      
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
          inherit inputs username self;
        };
      };

      devShells.${system} = {
        rustlings = pkgs.mkShell {
          buildInputs = with pkgs; [
            self.packages.${system}.hx-rust
            cargo
            rustlings
          ];

          shellHook = ''
            fish
          '';
        };

        quickshell = pkgs.mkShell {
          buildInputs = with pkgs; [
            inputs.quickshell.packages.${system}.default
            kdePackages.qtdeclarative
          ];

          shellHook = ''
            fish
          '';
        };

        python = pkgs.mkShell {
          buildInputs = with pkgs; [
            self.packages.${system}.hx-python
            python3
          ];

          shellHook = ''
            fish
          '';
        };
      };
    };
}
