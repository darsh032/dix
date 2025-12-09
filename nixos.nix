{ inputs, ... }: 
let
  username = "awesome";
in {
  flake = {
    nixosConfigurations.omen = inputs.nixpkgs.lib.nixosSystem {
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
  };
}
