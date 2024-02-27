{ lib, config, ... }:

let
  cfg = config.mods.system.time;
in

with lib;

{
  options.mods.system.time = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the time for the system.";
    };
    timeZone = mkOption {
      default = "Asia/Dhaka";
      example = "Asia/Tokyo";
      type = types.str;
      description = "THe timezone that the system will use.";
    };
  };

  config = mkIf cfg.enable {
    time = {
      inherit (cfg) timeZone;
      hardwareClockInLocalTime = true;
    };
  };
}
