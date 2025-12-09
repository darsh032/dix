{
  pkgs,
  inputs,
  ...
}: {
flake = {
    homeConfigurations = {
      awesome = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/main/home.nix
          ./home-manager/modules/default.nix
          inputs.spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = let
          username = "awesome";
          system = "x86_64-linux";
        in {
          inherit inputs username system;
        };
      };
    };
  };
}
