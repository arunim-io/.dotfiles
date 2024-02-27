{ lib, config, ... }:

let
  cfg = config.mods.hardware.sound;
in

with lib;

{
  options.mods.hardware.sound = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure sound for the system.";
    };
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
