{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.mods.apps.firefox;
in

with lib;

{
  options.mods.apps.firefox = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure firefox using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
  };
}
