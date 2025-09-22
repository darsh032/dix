{ ... }: {
  imports = [
    ./firefox.nix
    ./git.nix
    ./programs.nix
    ./kitty.nix
    ./hyprland.nix
    ./cursor.nix
    ./zellij.nix
    ./fish.nix
    ./spotify.nix
    ./starship.nix
    ./helix.nix
    ./setups/caelestia.nix
    ./setups/asztal.nix
  ];
}
