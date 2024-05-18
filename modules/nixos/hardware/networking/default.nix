{ lib, config, ... }:

let
  cfg = config.mods.hardware.networking;
in

with lib;

{
  options.mods.hardware.networking = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure networking for the system.";
    };
  };

  config = mkIf cfg.enable {
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        8080
        8081
      ];
    };
  };
}
