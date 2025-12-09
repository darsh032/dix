{ inputs, self', ... }:

let
  username = "awesome";
in {
  flake = {
    homeConfigurations.main = inputs.home-manager.lib.homeManagerConfiguration {
      inherit inputs;
      modules = [
        ./home-manager/main/home.nix
        ./home-manager/modules/default.nix
        inputs.spicetify-nix.homeManagerModules.default
      ];
      extraSpecialArgs = {
        inherit inputs username self';
      };
    };
  };
}
