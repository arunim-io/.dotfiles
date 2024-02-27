{ lib, config, ... }:

let
  cfg = config.mods.virt;
in

with lib;

{
  options.mods.virt = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure virtualisation.";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
