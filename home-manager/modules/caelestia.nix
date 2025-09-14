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

        bind = lib.mkMerge [
          [ "SUPER, SUPER_L, exec, caelestia shell drawers toggle launcher" ]
          [ "$mainMod Ctrl, R, exec, caelestia-shell kill;caelestia shell" ]
          [ "$mainMod Alt, C, exec, caelestia shell notifs clear" ]
          [ "$mainMod, L, global, caelestia:lock" ]
        ];
      };
    };
  };
}
