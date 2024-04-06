{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.mods.apps.vscode;
in

with lib;

{
  options.mods.apps.vscode = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure vscode using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
