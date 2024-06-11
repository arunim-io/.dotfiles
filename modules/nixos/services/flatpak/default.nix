{ lib, config, ... }:

let
  cfg = config.mods.services.flatpak;
in

with lib;

{
  options.mods.services.flatpak = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure flatpak support for the system.";
    };
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
