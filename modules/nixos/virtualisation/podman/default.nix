{ lib, config, ... }:

let
  cfg = config.mods.virt.podman;
in

with lib;

{
  options.mods.virt.podman = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure podman.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      networkSocket.openFirewall = true;
    };
  };
}
