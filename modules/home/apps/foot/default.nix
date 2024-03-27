{ lib, config, ... }:

let
  cfg = config.mods.apps.foot;
in

with lib;

{
  options.mods.apps.foot = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure foot using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "JetBrainsMono NF";
          box-drawings-uses-font-glyphs = true;
          dpi-aware = true;
          bold-text-in-bright = true;
        };
        mouse.hide-when-typing = true;
        key-bindings = {
          spawn-terminal = "Control+t";
          fullscreen = "F11";
        };
      };
    };
  };
}
