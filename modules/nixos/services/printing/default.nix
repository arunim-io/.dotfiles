{ lib, config, ... }:

let
  cfg = config.mods.services.printing;
in

with lib;

{
  options.mods.services.printing = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure printing support for the system.";
    };
  };

  config = mkIf cfg.enable { services.printing.enable = true; };
}
