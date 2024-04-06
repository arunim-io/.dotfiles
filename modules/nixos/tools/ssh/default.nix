{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.mods.tools.ssh;
in

with lib;

{
  options.mods.tools.ssh = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure OpenSSH support for the system.";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
