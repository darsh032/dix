{
  description = "Nixos config flake";


  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      wrappers,
      flake-parts,
      ...
    }@inputs:
    let
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

    flake-parts.lib.mkFlake {
      inherit inputs;
      
      imports = [
        ./nixos.nix
        ./home-manager.nix
      ];

      systems = [ "x86_64-linux" ];
      perSystem = { pkgs, self', ... }: {
        packages = {
          hx-regular = helix-regular;
          hx-python = helix-python;
          hx-rust = helix-rust;
        };

        devShells = {
          rustlings = pkgs.mkShell {
            buildInputs = with pkgs; [
              self'.packages.hx-rust
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
              self'.packages.hx-python
              python3
              manim
            ];

            shellHook = ''
              fish
            '';
          };
        };
      };
    };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    wrappers.url = "github:lassulus/wrappers";
    flake-parts.url = "github:hercules-ci/flake-parts";

    end4 = {
      url = "github:darsh032/dots-hyprland-fork-for-some-reason";
      flake = false;
    };

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
}
