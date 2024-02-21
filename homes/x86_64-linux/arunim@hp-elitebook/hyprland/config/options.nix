{ pkgs, ... }: {
  home.packages = with pkgs; [ networkmanagerapplet ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      "${pkgs.networkmanagerapplet}/bin/nm-applet"
      "${pkgs.waybar}/bin/waybar"
      "${pkgs.dunst}/bin/dunst"
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
  };
}
