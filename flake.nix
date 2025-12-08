{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    wrappers.url = "github:lassulus/wrappers";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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
      self,
      nixpkgs,
      home-manager,
      wrappers,
      ...
    }@inputs:
    let
      username = "awesome";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      packages.${system}.helix =
        wrappers.wrapperModules.helix.apply {
          inherit pkgs;

          settings = {
            theme = "catppuccin_mocha";

            editor = {
              soft-wrap.enable = true;
              line-number = "relative";
              color-modes = true;
              bufferline = "multiple";

              lsp.display-messages = true;

              statusline = {
                mode.normal = "NORMAL";
                mode.insert = "INSERT";
                mode.select = "SELECT";
                right = [ "file-type" "position" ];
              };

              cursor-shape = {
                insert = "bar";
                normal = "block";
                select = "block";
              };
            };
          };

          languages = {
            language = [
              {
                name = "nix";
                auto-format = false;
                indent = { tab-width = 2; unit = "  "; };
                language-servers = [ "scls" "nixd" ];
              }

              {
                name = "qml";
                auto-format = false;
                indent = { tab-width = 2; unit = "  "; };
                language-servers = [ "qmlls" "scls" ];
              }
            ];

            language-server = {
              scls = {
                command = "simple-completion-language-server";

                config = {
                  max_completion_items = 100;
                  feature_words = true;
                  feature_snippets = true;
                  snippets_first = true;
                  snippets_inline_by_word_trail = false;
                  feature_unicode_input = false;
                  feature_paths = true;
                  featue_citations = false;
                };

                enviornment = {
                  LOG_FILE = "/tmp/completion.log";
                  NIX_LOG = "info,simple-completion-language-server=info";
                };
              };
            };
          };

          themes = { };
          ignores = [ ];
        };

      nixosConfigurations.omen = nixpkgs.lib.nixosSystem {
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

      homeConfigurations.main = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home-manager/main/home.nix
          ./home-manager/modules/default.nix
          inputs.spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit inputs username;
        };
      };

      devShells.${system} = {
        rustlings = pkgs.mkShell {
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

        python = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            ruff
          ];
        };
      };
    };
}
