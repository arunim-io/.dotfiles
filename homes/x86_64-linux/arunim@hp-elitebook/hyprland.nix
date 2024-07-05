{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) getExe;
in
{
  home.packages = with pkgs; [ wl-clipboard ];

  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings =
      let
        mainMod = "SUPER";
      in
      {
        monitor = ",preferred,auto,auto";

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 1;

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 10;

          active_opacity = 1;
          inactive_opacity = 1;

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";

          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = false;
          enable_swallow = true;
          focus_on_activate = true;
          allow_session_lock_restore = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
            middle_button_emulation = true;
            clickfinger_behavior = true;
          };
        };

        gestures.workspace_swipe = false;

        bind =
          [
            "${mainMod}, Q, killactive,"
            "${mainMod}, V, togglefloating,"
            "${mainMod}, P, pseudo," # dwindle
            "${mainMod}, J, togglesplit," # dwindle
            "${mainMod}, left, movefocus, l"
            "${mainMod}, right, movefocus, r"
            "${mainMod}, up, movefocus, u"
            "${mainMod}, down, movefocus, d"

            "${mainMod}, F, exec, ${getExe pkgs.xfce.thunar}"
            "${mainMod}, RETURN, exec, ${getExe config.programs.foot.package}"
            "${mainMod}, M, exec, ${getExe config.programs.wofi.package} --show drun"
            "${mainMod}, B, exec, ${getExe pkgs.brave}"
          ]
          ++ (builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "${mainMod}, ${ws}, workspace, ${toString (x + 1)}"
                "${mainMod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          ))
          ++ [
            "${mainMod}, S, togglespecialworkspace, magic"
            "${mainMod} SHIFT, S, movetoworkspace, special:magic"

            "${mainMod}, mouse_down, workspace, e+1"
            "${mainMod}, mouse_up, workspace, e-1"
          ]
          ++ (
            let
              player = getExe pkgs.playerctl;
              wpctl = lib.getExe' pkgs.wireplumber "wpctl";
              brightness = getExe pkgs.brightnessctl;
              screenshot = getExe pkgs.grimblast;
            in
            [
              ", XF86AudioPlay, exec, ${player} play-pause"
              ", XF86AudioNext, exec, ${player} next"
              ", XF86AudioPrev, exec, ${player} previous"
              ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              ", XF86MonBrightnessUp, exec, ${brightness} set +10%"
              ", XF86MonBrightnessDown, exec, ${brightness} set 10%-"
              # ", switch:Lid Switch, exec, swaylock"
              # "$mod SHIFT, Q, exec, ${wlogout}/bin/wlogout"
              ", PRINT, exec, ${screenshot} --notify --freeze copysave screen"
              "${mainMod}, PRINT, exec, ${screenshot} --notify --freeze copysave window"
              "${mainMod} SHIFT, PRINT, exec, ${screenshot} --notify --freeze copysave area"
            ]
          );
        bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
        ];

        windowrulev2 = [ "suppressevent maximize, class:.*" ];
      };
  };
}
