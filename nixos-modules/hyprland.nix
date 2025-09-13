{inputs, pkgs, config, lib, ...}:  {
  options = {
    moduleHyprland.enable = lib.mkEnableOption "enables hyprland" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleHyprland.enable {
     programs.hyprland = {
       enable = true;
       package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
       portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
     };
  };
}
