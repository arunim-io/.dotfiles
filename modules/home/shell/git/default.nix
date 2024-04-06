{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (config.mods) shell;
  inherit (config.mods.home) user;
  cfg = shell.git;
in

with lib;

{
  options.mods.shell.git = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure git using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ act ];

    programs = {
      git = {
        enable = true;
        delta.enable = true;
        userName = user.name;
        userEmail = user.email;
      };

      gh = {
        enable = true;
        settings.git_protocol = "https";
      };

      lazygit.enable = true;
    };
  };
}
