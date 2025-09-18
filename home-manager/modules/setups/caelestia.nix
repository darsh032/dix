{ config, lib, inputs, pkgs, ... }: {
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
        source = "~/.config/hypr/scheme/current.conf";
        
        exec-once = [
          "caelestia shell" 
          "wl-paste --type text --watch cliphist store" 
          "wl-paste --type image --watch cliphist store" 
        ]; 

        bind = [
          "Super Ctrl, R, exec, caelestia-shell kill;caelestia shell"
          "Super Alt, C, global, caelestia:clearNotifs"
          "Super, L, global, caelestia:lock"
          "Super Shift, S, exec,  caelestia screenshot -r -f"
          "Super, V, exec, pkill fuzzel || caelestia clipboard"
          "Super Alt, V, exec, pkill fuzzel || caelestia clipboard -d"
          "Super, ., exec, pkill fuzzel || caelestia emoji -p"
          "Super, Esc, global, caelestia:launcher"
        ];

        general = lib.mkForce {
          "col.active_border" = "rgba($primarye6)";
          "col.inactive_border" = "rgba($onSurfaceVariant11)";
        };
      };
    };

    programs.fish.shellInit = "
      cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    ";
  };
}
