{ pkgs, ... }: {
  environment = {
    localBinInPath = true;
    homeBinInPath = true;
  };

  users.users.arunim = {
    isNormalUser = true;
    description = "Mugdha Arunim Ahmed";
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "podman" ];
    shell = pkgs.fish;
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
  };
}
