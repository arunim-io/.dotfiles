{ lib, config, pkgs, ... }:

let
  cfg = config.mods.theming;
in

with lib;
{
  options.mods.theming = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to set themes using home-manager.";
    };
    enableDarkMode = mkOption {
      default = true;
      example = true;
      type = types.bool;
      description = "Whether to enable dark mode.";
    };
    theme = mkOption {
      default = "adwaita";
      example = "adwaita";
      type = types.enum [ "adwaita" ];
      description = "The name of the theme tobe used for styling apps.";
    };
  };

  config = mkIf cfg.enable {
    gtk =
      let
        extraConfig.gtk-application-prefer-dark-theme = cfg.enableDarkMode;
      in
      {
        enable = true;
        iconTheme = {
          package = pkgs.gnome.adwaita-icon-theme;
          name = "Adwaita-dark";
        };
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
        gtk3 = { inherit extraConfig; };
        gtk4 = { inherit extraConfig; };
      };

    qt = {
      enable = true;
      style.name = "adwaita-dark";
    };

    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
