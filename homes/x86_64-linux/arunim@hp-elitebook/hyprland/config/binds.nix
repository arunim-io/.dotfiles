{ pkgs, ... }:
let
  window-binds = [
    "$mod, Q, killactive"
    "$mod, V, togglefloating"
    "$mod, P, pseudo"
    "$mod, J, togglesplit"
    "$mod, left, movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up, movefocus, u"
    "$mod, down, movefocus, d"
  ];
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
  system-binds =
    let
      playerctl = "${pkgs.playerctl}/bin/playerctl";
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      grimblast = "${pkgs.grimblast}/bin/grimblast";
    in
    [
      ", XF86AudioPlay, exec, ${playerctl} play-pause"
      ", XF86AudioNext, exec, ${playerctl} next"
      ", XF86AudioPrev, exec, ${playerctl} previous"
      ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, ${brightnessctl} set +10%"
      ", XF86MonBrightnessDown, exec, ${brightnessctl} set 10%-"
      # ", switch:Lid Switch, exec, swaylock"
      "$mod SHIFT, Q, exec, ${pkgs.wlogout}/bin/wlogout"
      ", PRINT, exec, ${grimblast} --notify --freeze copysave screen"
      "$mod, PRINT, exec, ${grimblast} --notify --freeze copysave window"
      "$mod SHIFT, PRINT, exec, ${grimblast} --notify --freeze copysave area"
    ];
  app-binds = [
    "$mod, RETURN, exec, wezterm"
    "$mod, C, exec, code"
    "$mod, D, exec, wofi --show drun"
    "$mod, E, exec, thunar"
    "$mod, F, exec, firefox"
    "$mod, S, exec, spotify"
  ];
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = window-binds ++ workspace-binds ++ system-binds ++ app-binds;
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
