{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./system
    ./virt.nix
    ./hyprland.nix
    ./podman.nix
  ];

  networking.hostName = "hp-elitebook";
  system.stateVersion = "23.11";

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "arunim" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
