{ ... }: {
   imports = [
        ./chromium.nix
        ./git.nix
	./kitty.nix
	./hyprland.nix
        ./cursor.nix
        ./zellij.nix
        ./fish.nix
        ./spotify.nix
        ./starship.nix
        ./setups/caelestia.nix
        ./setups/asztal.nix
   ];
}
