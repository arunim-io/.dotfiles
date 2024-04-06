{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.mods.user;

  getUserGroup = condition: groupName: if condition then [ groupName ] else [ ];
in

with lib;

{
  options.mods.user = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure an user account for the system.";
    };
    username = mkOption {
      default = "arunim";
      example = "johndoe";
      type = types.str;
      description = "The identifier for the user account.";
    };
    name = mkOption {
      default = "Mugdha Arunim Ahmed";
      example = "John Doe";
      type = types.str;
      description = "The full name of the user.";
    };
    email = mkOption {
      default = "mugdhaarunimahmed2017@gmail.com";
      example = "johndoe@gmail.com";
      type = types.str;
      description = "The email of the user.";
    };
    shell = mkOption {
      default = pkgs.fish;
      example = literalExpression "pkgs.bash";
      type = types.package;
      description = "The package to use for the user shell.";
    };
    extraGroups = mkOption {
      default = [ ];
      type = types.listOf types.str;
      description = "The list of user groups the user is part of.";
    };
    extraOptions = mkOption {
      default = { };
      type = types.attrs;
      description = "Extra options used in configuring the user account.";
    };
  };

  config = mkIf cfg.enable {
    nix.settings.trusted-users = [ cfg.username ];
    users.users.${cfg.username} = {
      inherit (cfg) shell;

      isNormalUser = true;
      description = cfg.name;
      extraGroups =
        [
          "wheel"
          "input"
        ]
        ++ cfg.extraGroups
        ++ getUserGroup config.networking.networkmanager.enable "networkmanager"
        ++ getUserGroup config.virtualisation.libvirtd.enable "libvirtd"
        ++ getUserGroup config.virtualisation.podman.enable "podman";
    } // cfg.extraOptions;

    programs.fish = {
      enable = cfg.shell == pkgs.fish;
      useBabelfish = true;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
