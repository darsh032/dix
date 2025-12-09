{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    wrappers.url = "github:lassulus/wrappers";
    flake-parts.url = "github:hercules-ci/flake-parts";

    quickshell = {
      url = "github:quickshell-mirror/quickshell/master";
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
      nixpkgs,
      wrappers,
      home-manager,
      flake-parts,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "awesome";

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

    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.home-manager.flakeModules.home-manager
        ./nixos.nix
        ./wrappers/helix/helix.nix
      ];

      systems = [ "x86_64-linux" ];

      
    }
}
