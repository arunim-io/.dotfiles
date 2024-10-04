{ pkgs, ... }:
{
  gtk =
    let
      extraConfig.gtk-application-prefer-dark-theme = true;
    in
    {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      gtk3 = {
        inherit extraConfig;
      };
      gtk4 = {
        inherit extraConfig;
      };
    };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
