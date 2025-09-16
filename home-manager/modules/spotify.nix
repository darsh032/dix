{ lib, config, pkgs, inputs, ... }: {
  options = {
    moduleSpotify.enable = lib.mkEnableOption "enables spotify" // {    
      default = true; }; };

  config = lib.mkIf config.moduleSpotify.enable {
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
      {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
