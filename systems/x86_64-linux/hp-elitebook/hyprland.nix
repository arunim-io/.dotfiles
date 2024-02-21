{ pkgs, inputs, system, ... }: {
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [ polkit_gnome ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-volman thunar-archive-plugin ];
    };

    xfconf.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
  };
}
