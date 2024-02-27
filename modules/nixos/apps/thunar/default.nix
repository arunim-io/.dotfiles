{ lib, config, pkgs, ... }:

let
  cfg = config.mods.apps.thunar;
in

with lib;

{
  options.mods.apps.thunar = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure thunar.";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
      };

      xfconf.enable = true;
    };

    services = {
      gvfs.enable = true;
      tumbler.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
    };
  };
}
