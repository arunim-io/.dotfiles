{ lib, config, pkgs, inputs, system, ... }:

let
  cfg = config.mods.wm.hyprland;
in

with lib;

{
  options.mods.wm.hyprland = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure hyprland.";
    };
  };

  config = mkIf cfg.enable {
    environment = {
      sessionVariables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [ polkit_gnome gnome.gnome-bluetooth libdbusmenu-gtk3 ];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
    };

    networking.networkmanager.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
      pipewire.pulse.enable = true;
      upower = {
        enable = true;
        percentageLow = 25;
        percentageCritical = 10;
        percentageAction = 5;
      };
      gvfs.enable = true;
    };

    mods.apps.thunar.enable = true;
  };
}
