{ config, lib, inputs, pkgs, ... }: {
  options = {
    moduleAsztal.enable = lib.mkEnableOption "enables caelestia";
  };

  config = lib.mkIf config.moduleAsztal.enable {
    home.packages = with pkgs; [
      inputs.asztal.packages.${system}.default
      libnotify
      swaylock
    ];

    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
           "asztal" 
        ]; 

        bind = [
           "SUPER, SUPER_L, exec, asztal -t launcher" 
           "$mainMod, Tab, exec, asztal -t overview" 
           "$mainMod Ctrl, R, exec, pkill .ags-wrapped;asztal" 
           "$mainMod, L, exec, swaylock" 
        ];
      };
    };
  };
}
