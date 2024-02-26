{ lib, config, pkgs, ... }:

let
  cfg = config.mods.wm.hyprland;
in

with lib;

{
  options.mods.wm.hyprland = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure hyprland using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      cliphist
      networkmanagerapplet
      pavucontrol
      wofi
      wezterm
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = with pkgs; [
          "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
          "${networkmanagerapplet}/bin/nm-applet"
          "${waybar}/bin/waybar"
          "${dunst}/bin/dunst"
        ];

        monitor = ",preferred,auto,1.25g";

        env = [
          "QT_QPA_PLATFORM,wayland"
          "GDK_BACKEND,wayland"
          "GDK_SCALE,2"
        ];

        general = {
          gaps_in = 2.5;
          gaps_out = 0;
          border_size = 2;
          "col.active_border" = "rgba(ffffffff)";
          "col.inactive_border" = "rgba(ffffff55)";
          layout = "dwindle";
        };

        dwindle = {
          force_split = 2;
          pseudotile = true;
          preserve_split = true;
        };

        decoration = {
          rounding = 5;
          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            enabled = true;
            size = 3;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.00";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        input = {
          kb_layout = "us";
          touchpad = {
            natural_scroll = true;
            middle_button_emulation = true;
          };
        };

        gestures.workspace_swipe = true;

        misc = {
          disable_hyprland_logo = true;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;
        };

        xwayland.force_zero_scaling = true;

        "$mod" = "SUPER";
        bind =
          let
            workspace-binds =
              let
                no = 10;
              in
              builtins.concatLists (builtins.genList
                (x:
                  let
                    ws = builtins.toString (x + 1 - (((x + 1) / no) * no));
                  in
                  [
                    "$mod, ${ws}, workspace, ${toString (x + 1)}"
                    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                  ]
                )
                no);
            system-binds = with pkgs;
              let
                player = "${playerctl}/bin/playerctl";
                wpctl = "${wireplumber}/bin/wpctl";
                brightness = "${brightnessctl}/bin/brightnessctl";
                screenshot = "${grimblast}/bin/grimblast";
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
                "$mod SHIFT, Q, exec, ${wlogout}/bin/wlogout"
                ", PRINT, exec, ${screenshot} --notify --freeze copysave screen"
                "$mod, PRINT, exec, ${screenshot} --notify --freeze copysave window"
                "$mod SHIFT, PRINT, exec, ${screenshot} --notify --freeze copysave area"
              ];
          in
          [
            "$mod, Q, killactive"
            "$mod, V, togglefloating"
            "$mod, P, pseudo"
            "$mod, J, togglesplit"
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"

            "$mod, RETURN, exec, wezterm"
            "$mod, C, exec, code"
            "$mod, D, exec, wofi --show drun"
            "$mod, E, exec, thunar"
            "$mod, F, exec, firefox"
            "$mod, S, exec, spotify"
          ] ++ workspace-binds ++ system-binds;
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
