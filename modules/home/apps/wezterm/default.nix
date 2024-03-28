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
      extraConfig = /* lua */ ''
        local config = wezterm.config_builder() or {}

        config.use_fancy_tab_bar = false
        config.hide_tab_bar_if_only_one_tab = true

        return config
      '';
    };
  };
}
