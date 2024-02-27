{ lib, config, ... }:

let
  cfg = config.mods.system.boot;
in

with lib;

{
  options.mods.system.boot = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the bootloader for the system.";
    };
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };
      kernel.sysctl."vm.swappiness" = 10;
      supportedFilesystems = [ "ntfs" ];
    };
  };
}
