{
  lib,
  config,
  pkgs,
  inputs,
  system,
  ...
}:

let
  cfg = config.mods.system.fonts;
in

with lib;

{
  options.mods.system.fonts = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure fonts for the system.";
    };
    extraFonts = mkOption {
      default = [ ];
      type = types.listOf types.package;
      description = "Extra fonts to install on the system.";
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      packages =
        with pkgs;
        [
          font-awesome
          material-design-icons
          ubuntu_font_family
          noto-fonts
          noto-fonts-emoji
          (nerdfonts.override {
            fonts = [
              "JetBrainsMono"
              "UbuntuMono"
            ];
          })
        ]
        ++ cfg.extraFonts;
      fontDir.enable = true;
      enableDefaultPackages = true;
      fontconfig = {
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "Ubuntu"
            "Noto Serif"
          ];
          emoji = [ "Noto Color Emoji" ];
          sansSerif = [
            "Ubuntu"
            "Noto Sans"
          ];
          monospace = [
            "JetBrains Nerd Font"
            "Ubuntu Mono"
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
