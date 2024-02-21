self: {
  imports = [ ./options.nix ./binds.nix ];
  wayland.windowManager.hyprland.enable = true;
}
