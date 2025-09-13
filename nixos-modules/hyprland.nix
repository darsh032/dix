{inputs, pkgs, config, lib, ...}:  {
  options = {
    moduleHyprland = lib.mkEnableOption "enables hyprland" // {
      default = true;
    };
  }

  config = lilb.mkIf enable.moduleHyprland.enable {
     programs.hyprland = {
       enable = true;
       package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
       portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
     };
  };
}
