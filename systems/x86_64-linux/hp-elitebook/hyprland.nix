{ inputs, system, ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
  };

  security.pam.services.hyprlock = { };
}
