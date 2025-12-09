{ pkgs, inputs, ... }: 
let
  username = "awesome";
in {
  flake = {
    nixosConfigurations.omen = pkgs.lib.nixosSystem {
      specialArgs = { inherit inputs username; };
      modules = [
        ./nixos-modules/default.nix
        ./system/default.nix
        ./hosts/omen/configuration.nix
      ];
    };
  }
}
