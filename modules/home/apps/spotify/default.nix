{ lib, config, inputs, system, ... }:

let
  cfg = config.mods.apps.spotify;

  inherit (inputs.spicetify.packages.${system}.default) apps extensions;
in

with lib;

{
  options.mods.apps.spotify = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure spotify using spicetify & home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      enabledCustomApps = with apps; [
        marketplace
        lyrics-plus
      ];
      enabledExtensions = with extensions; [
        adblock
        volumePercentage
        fullAlbumDate
      ];
    };

  };
}
