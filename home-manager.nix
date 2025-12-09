{ inputs, ... }:

let
  username = "awesome";
in
{
  flake.homeConfigurations.main = {
      modules = [
        ./home-manager/main/home.nix
        ./home-manager/modules/default.nix
        inputs.spicetify-nix.homeManagerModules.default
      ];

      extraSpecialArgs = {
        inherit inputs username ;
      };
    };
}
