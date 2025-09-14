{ config, lib, inputs, pkgs, system, ... }: {
  options = {
    moduleCaelestia.enable = lib.mkEnableOption "enables caelestia";
  };

  config = lib.mkIf config.moduleCaelestia.enable {
    home.packages = with pkgs; [
      inputs.caelestia-shell.packages.${system}.default
      inputs.caelestia-cli.packages.${system}.default
      libnotify
      wl-clipboard
      cliphist
    ];

    wayland.windowManager.hyprland = {
      settings = {
        exec-once = lib.mkMerge [
          [ "caelestia shell" ]
          [ "wl-paste --type text --watch cliphist store" ]
          [ "wl-paste --type image --watch cliphist store" ]
        ]; 

        bind = lib.mkMerge [
          [ "SUPER, SUPER_L, global, caelestia:launcher" ]
          [ "$mainMod Ctrl, R, exec, caelestia-shell kill;caelestia shell" ]
          [ "$mainMod Alt, C, global, caelestia:clearNotifs" ]
          [ "$mainMod, L, global, caelestia:lock" ]
          [ "$mainMod Shift, S, exec,  caelestia screenshot -r -f" ]
          [ "$mainMod, V, exec, pkill fuzzel || caelestia clipboard" ]
          [ "$mainMod Alt, V, exec, pkill fuzzel || caelestia clipboard -d" ]
          [ "$mainMod, ., exec, pkill fuzzel || caelestia emoji -p" ]
        ];
      };
    };

    programs.fish.shellInit = "
                            cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

                        ";
  };
}
