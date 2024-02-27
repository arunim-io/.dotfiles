{ lib, config, pkgs, ... }:

let
  cfg = config.mods.system;
in

with lib;

{
  options.mods.system = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure the system.";
    };
    hostName = mkOption {
      example = "framework-laptop";
      type = types.str;
      description = "The host name of the system.";
    };
    shells = mkOption {
      default = with pkgs; [ bash fish ];
      type = types.listOf types.package;
      description = "The shells to install on the system.";
    };
    packages = mkOption {
      default = [ ];
      type = types.listOf types.package;
      description = "The packages to install on the system.";
    };
  };

  config = mkIf cfg.enable
    {
      nix = {
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "auto-allocate-uids"
            "configurable-impure-env"
            "nix-command"
            "flakes"
            "repl-flake"
          ];
        };
      };

      environment = {
        inherit (cfg) shells;

        localBinInPath = true;
        homeBinInPath = true;
        systemPackages = cfg.packages ++ (with pkgs; [
          git
          gnupg
          curl
          wget
          aria2
          killall
          htop
          nettools
          inxi
        ]);
      };
    };
}
