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
  programs.wofi.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings =
      let
        terminal = getExe config.programs.foot.package;
        fileManager = getExe pkgs.xfce.thunar;
        appMenu = "${getExe config.programs.wofi.package} --show drun";
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
          gaps_out = 20;

          border_size = 2;

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 10;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

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
          };
        };

        gestures = {
          workspace_swipe = false;
        };

        bind =
          [
            "${mainMod}, Q, exec, ${terminal}"
            "${mainMod}, C, killactive,"
            "${mainMod}, M, exit,"
            "${mainMod}, E, exec, ${fileManager}"
            "${mainMod}, V, togglefloating,"
            "${mainMod}, R, exec, ${appMenu}"
            "${mainMod}, P, pseudo," # dwindle
            "${mainMod}, J, togglesplit," # dwindle

            "${mainMod}, left, movefocus, l"
            "${mainMod}, right, movefocus, r"
            "${mainMod}, up, movefocus, u"
            "${mainMod}, down, movefocus, d"
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
          ];
        bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
        ];

        windowrulev2 = [ "suppressevent maximize, class:.*" ];
      };
  };
}
