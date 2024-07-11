{
  imports = [
    ./hardware-configuration.nix
    ./nix.nix
    ./boot.nix
    ./power.nix
    ./networking.nix
    ./sound.nix
    ./bluetooth.nix
    ./user.nix
    ./sops.nix
    ./shell.nix
    ./fonts.nix
    ./hyprland.nix
  ];

  system.stateVersion = "24.11";
  networking.hostName = "hp-elitebook";
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_GB.UTF-8";
}
