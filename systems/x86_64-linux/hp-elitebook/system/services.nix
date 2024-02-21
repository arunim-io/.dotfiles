self: {
  services = {
    printing.enable = true;
    flatpak.enable = true;

    openssh = {
      enable = true;
      openFirewall = true;
    };

    gnome.gnome-keyring.enable = true;
    input-remapper.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };
}
