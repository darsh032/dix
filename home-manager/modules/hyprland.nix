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
          gaps_in = 4;
          gaps_out = 5;
          gaps_workspaces = 50;

          border_size = 0;
          "col.active_border" = "rgba(0DB7D4FF)";
          "col.inactive_border" = "rgba(31313600)";
          resize_on_border = true;

          no_focus_fallback = true;

          allow_tearing = true;

          snap = {
          	enabled = true;
          	window_gap = 4;
          	monitor_gap = 5;
          	respect_gaps = true;
          };
        };

        decoration = {
            rounding = 18;

            blur = {
                enabled = true;
                xray = true;
                special = false;
                new_optimizations = true;
                size = 10;
                passes = 3;
                brightness = 1;
                noise = 0.15;
                contrast = 0.2;
                vibrancy = 0.8;
                vibrancy_darkness = 0.8;
                popups = false;
                popups_ignorealpha = 0.6;
                input_methods = true;
                input_methods_ignorealpha = 0.8;
            };

            shadow = {
                enabled = true;
                ignore_window = true;
                range = 30;
                offset = "0 2";
                render_power = 4;
                color = "rgba(00000010)";
            };

            # Dim
            dim_inactive = true;
            dim_strength = 0.025;
            dim_special = 0.07;
        };

        animations = {
          enabled = true;
  
          bezier = [
            "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
            "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
            "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
            "emphasizedDecel, 0.05, 0.7, 0.1, 1"
            "emphasizedAccel, 0.3, 0, 0.8, 0.15"
            "standardDecel, 0, 0, 0, 1"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.52, 0.03, 0.72, 0.08"
            "stall, 1, -0.1, 0.7, 0.85"
          ];

          animation = [
            "windowsIn, 1, 3, emphasizedDecel, popin 80%"
            "fadeIn, 1, 3, emphasizedDecel"
            "windowsOut, 1, 2, emphasizedDecel, popin 90%"
            "fadeOut, 1, 2, emphasizedDecel"
            "windowsMove, 1, 3, emphasizedDecel, slide"
            "border, 1, 10, emphasizedDecel"
            "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
            "layersOut, 1, 2.4, menu_accel, popin 94%"
            "fadeLayersIn, 1, 0.5, menu_decel"
            "fadeLayersOut, 1, 2.7, stall"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
            "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
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
          "Super+Alt, F, fullscreenstate, 0 3"
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
