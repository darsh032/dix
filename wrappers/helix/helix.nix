{ pkgs, wrappers, ... }: let
  helix-regular = import ./wrappers/helix/helix-regular.nix {
    inherit pkgs wrappers;
  };

  helix-python = import ./wrappers/helix/helix-python.nix {
    inherit pkgs wrappers;
  };

  helix-rust = import ./wrappers/helix/helix-rust.nix {
    inherit pkgs wrappers;
  };
in {
  perSystem = { inputs, self', ... }: {
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
}
