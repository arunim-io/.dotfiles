{ lib, config, ... }:

let
  cfg = config.mods.system.locale;
in

with lib;

{
  options.mods.system.locale = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the locale for the system.";
    };
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_GB.UTF-8";
  };
}
