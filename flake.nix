{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hjem.url = "github:feel-co/hjem";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./nixos-modules/default.nix
          ./system/default.nix
          ./hosts/omen/configuration.nix
          ./users/awesome.nix
          inputs.hjem.nixosModules.default
        ];
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
            inputs.quickshell.packages.${system}.default
            kdePackages.qtdeclarative
          ];
        };
      };
    };
}
