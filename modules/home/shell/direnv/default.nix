{ lib, config, ... }:

let
  cfg = config.mods.shell.direnv;
in

with lib;

{
  options.mods.shell.direnv = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure direnv using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      stdlib = "source ~/.config/direnv/layout_poetry.sh";
    };

    home.file.layout-poetry = {
      source = ./layout_poetry.sh;
      target = "./.config/direnv/layout_poetry.sh";
    };
  };
}
