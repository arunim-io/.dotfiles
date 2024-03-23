{ lib, config, ... }:

let
  cfg = config.mods.apps.wezterm;
in

with lib;

{
  options.mods.apps.wezterm = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure wezterm using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      colorSchemes.terafox = (importTOML ./terafox-theme.toml).colors;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
