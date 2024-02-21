{ pkgs, ... }: {
  imports = [ ./config ];
  home = {
    packages = with pkgs; [
      pavucontrol
      cliphist
      wl-clipboard
      kitty
      wezterm
      wofi
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 32;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gnome3";
  };
}
