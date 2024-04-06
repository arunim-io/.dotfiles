{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (pkgs) fetchFromGitHub;
  cfg = config.mods.shell;
in

with lib;

{
  options.mods.shell = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the commandline shell using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      starship.enable = true;
      zoxide.enable = true;
      bat.enable = true;
    };
    mods.shell.fish.enable = true;
  };
}
