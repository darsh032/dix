{ config, lib, inputs, pkgs, system, ... }: {
  options = {
    moduleCaelestia.enable = lib.mkEnableOption "enables caelestia" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleCaelestia.enable {
    home.packages = with pkgs; [
      inputs.caelestia-shell.packages.${system}.default
      inputs.caelestia-cli.packages.${system}.default
    ];

    wayland.windowManager.hyprland = {
      settings = {
         exec-once = lib.mkMerge [
           [ "caelestia shell" ]
         ]; 
      };
    };
  };
}
