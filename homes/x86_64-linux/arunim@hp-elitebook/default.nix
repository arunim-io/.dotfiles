{ pkgs, lib, ... }: {
  imports = [
    ./coding.nix
    ./shell.nix
    ./hyprland
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "23.11";
    username = "arunim";
    homeDirectory = "/home/arunim";

    packages = with pkgs; [
      zoom-us
      webcord
      topgrade
    ];
  };

  programs = {
    home-manager.enable = true;

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita-dark";
    };
    theme = {
      name = "Adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
