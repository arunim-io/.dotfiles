{ lib, config, ... }:

let
  cfg = config.mods.home;

  inherit (cfg.user) username home;
in

with lib;

{
  options.mods.home = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the user account using home-manager.";
    };
    user = {
      username = mkOption {
        default = "arunim";
        example = "johndoe";
        type = types.str;
        description = "The identifier for the user";
      };
      name = mkOption {
        default = "Mugdha Arunim Ahmed";
        example = "John Doe";
        type = types.str;
        description = "The full name of the user";
      };
      email = mkOption {
        default = "mugdhaarunimahmed2017@gmail.com";
        example = "johndoe@gmail.com";
        type = types.str;
        description = "The email of the user";
      };
      home = mkOption {
        default = "/home/${username}";
        example = "John Doe";
        type = types.str;
        description = "The full name of the user";
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;
    home = {
      inherit username;
      homeDirectory = home;
    };
  };
}
