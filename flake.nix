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
        overlays = [
                (final: prev: {
                 neovim = (inputs.nvf.lib.neovimConfiguration {
                                 pkgs = prev;
                                 modules = [ ./nvim/nvf.nix ];
                                 }).neovim;
                 })
        ];
        pkgs = import nixpkgs {
                inherit system overlays;
                config.allowUnfree = true;
        };
        in {

                packages.${system}.nvf = pkgs.neovim;

                nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
                        specialArgs = {inherit inputs username;};
                        modules = [
                        {
# nixpkgs.overlays = overlays;
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

                        ];
                        extraSpecialArgs = {
                                inherit inputs username;
                        };
                };
        };
}
