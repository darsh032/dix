{ config, lib, ... }:

let
  input_options = "caps:escape";
in{
  options = {
    moduleHyprland.enable = lib.mkEnableOption "Enables hyprland" // {
      default = true;
    };

    moduleHyprland.colemak = lib.mkEnableOption "enables colemak" // {
      default = true;
    };
  };

  config = lib.mkIf config.moduleHyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
           
      settings = {
        monitor = ",preferred,auto,auto";

        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 20;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 8;
            render_power = 8;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 10;
            passes = 5;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = "yes, please :)";

          bezier = [
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];

          animation = [
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.49,  linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  easeOutQuint, slide"
            "workspacesIn,  1,     1.21,  easeOutQuint, slide"
            "workspacesOut, 1,     1.94,  easeOutQuint, slide"
            "zoomFactor,    1,     7,     quick"
          ];

        };

        exec-once = [
          "hyprctl setcursor Bibata-Modern-Classic 19" 
        ];

        dwindle = {
          pseudotile = true ;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = false;
          disable_hyprland_logo = true;
        };

        input = lib.mkMerge [
            {
              kb_layout = "us";
              kb_options = "${input_options}";
              repeat_rate = 40;
              repeat_delay = 200;
              follow_mouse = 1;
              sensitivity = 0;
              touchpad = {
                natural_scroll = false;
              };
            }

            (lib.mkIf config.moduleHyprland.colemak {
              kb_layout = lib.mkForce "us,us";
              kb_variant = lib.mkForce "colemak_dh_ortho";
              resolve_binds_by_sym = 1;
              kb_options = lib.mkForce "grp:alt_shift_toggle,${input_options}";
            })
        ];
        
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        bind = [
          "Super, F, fullscreen"
          "Super, T, exec, $terminal"
          "Super, Q, killactive,"
          "Super, M, exit,"
          "Super, E, exec, $fileManager"
          "Super, Space, togglefloating,"
          "Super, P, pseudo, "
          "Super, J, togglesplit, "
          "Super, left, movefocus, l"
          "Super, right, movefocus, r"
          "Super, up, movefocus, u"
          "Super, down, movefocus, d"
          "Super, 1, workspace, 1"
          "Super, 2, workspace, 2"
          "Super, 3, workspace, 3"
          "Super, 4, workspace, 4"
          "Super, 5, workspace, 5"
          "Super, 6, workspace, 6"
          "Super, 7, workspace, 7"
          "Super, 8, workspace, 8"
          "Super, 9, workspace, 9"
          "Super, 0, workspace, 10"
          "Super SHIFT, 1, movetoworkspace, 1"
          "Super SHIFT, 2, movetoworkspace, 2"
          "Super SHIFT, 3, movetoworkspace, 3"
          "Super SHIFT, 4, movetoworkspace, 4"
          "Super SHIFT, 5, movetoworkspace, 5"
          "Super SHIFT, 6, movetoworkspace, 6"
          "Super SHIFT, 7, movetoworkspace, 7"
          "Super SHIFT, 8, movetoworkspace, 8"
          "Super SHIFT, 9, movetoworkspace, 9"
          "Super SHIFT, 0, movetoworkspace, 10"
          "Super, S, togglespecialworkspace, special"
          "Super Alt, S, movetoworkspace, special"
          "Super, mouse_down, workspace, +1"
          "Super, mouse_up, workspace, -1"
        ];

        bindm = [
          "Super, mouse:272, movewindow"
          "Super, mouse:273, resizewindow"
        ];
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

      };
    };
  };
}
