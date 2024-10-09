{
  lib,
  config,
  pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (lib) getExe getExe';

  playerctl = getExe pkgs.playerctl;
  wpctl = getExe' pkgs.wireplumber "wpctl";
  brightnessctl = getExe pkgs.brightnessctl;
  grimblast = getExe pkgs.grimblast;
  loginctl = getExe' pkgs.systemd "loginctl";
  hyprctl = getExe' pkgs.hyprland "hyprctl";
  hyprlock = getExe config.programs.hyprlock.package;
  systemctl = getExe' pkgs.systemd "systemctl";
in
{
  home.packages = with pkgs; [ wl-clipboard ];

  programs.hyprlock = {
    enable = true;
    settings.general = {
      ignore_empty_input = true;
      hide_cursor = true;
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof ${hyprlock} || ${hyprlock}";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };

      listener = [
        {
          timeout = 600; # 10min
          on-timeout = "${brightnessctl} -s set 10"; # Set monitor backlight to min
          on-resume = "${brightnessctl} -r"; # monitor backlight restore.
        }
        {
          timeout = 600; # 10min
          on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "${brightnessctl} -rd rgb:kbd_backlight"; # turn on keyboard backlight.
        }
        {
          timeout = 600; # 10min
          on-timeout = "${loginctl} lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 900; # 15min
          on-timeout = "${hyprctl} dispatch dpms off"; # screen off when timeout has passed
          on-resume = "${hyprctl} dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800; # 30min
          on-timeout = "${systemctl} suspend"; # suspend pc
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings =
      let
        ags = inputs.ags.packages.${system}.default;
      in
      {
        monitor = ",preferred,auto,auto";

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        exec-once = [
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
          (getExe pkgs.networkmanagerapplet)
          (getExe' pkgs.blueman "blueman-applet")
          ags
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
          disable_hyprland_logo = true;
          enable_swallow = true;
          focus_on_activate = true;
          allow_session_lock_restore = true;
        };

        input = {
          kb_layout = "us";

          follow_mouse = 1;

          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
            middle_button_emulation = true;
            clickfinger_behavior = true;
          };
        };

        gestures.workspace_swipe = false;

        "$mod" = "SUPER";

        bind =
          (builtins.concatLists (
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
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          ))
          ++ [
            "$mod, Q, killactive,"
            "$mod, V, togglefloating,"
            "$mod, P, pseudo," # dwindle
            "$mod, J, togglesplit," # dwindle
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"

            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            ", XF86AudioPlay, exec, ${playerctl} play-pause"
            ", XF86AudioNext, exec, ${playerctl} next"
            ", XF86AudioPrev, exec, ${playerctl} previous"
            ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86MonBrightnessUp, exec, ${brightnessctl} set +10%"
            ", XF86MonBrightnessDown, exec, ${brightnessctl} set 10%-"

            "$mod, M, exec, ${ags} -t app-launcher"
            "$mod SHIFT, Q, exec, ${ags} -t power-menu"
            "$mod, F, exec, ${getExe pkgs.xfce.thunar}"
            "$mod, RETURN, exec, ${getExe config.programs.foot.package}"
            "$mod, B, exec, ${getExe pkgs.brave}"
            "$mod, R, exec, ${ags} -q; ${ags}"
            ", PRINT, exec, ${grimblast} --notify --freeze copysave screen"
            "$mod, PRINT, exec, ${grimblast} --notify --freeze copysave window"
            "$mod SHIFT, PRINT, exec, ${grimblast} --notify --freeze copysave area"
          ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        windowrulev2 = [ "suppressevent maximize, class:.*" ];
      };
  };
}
