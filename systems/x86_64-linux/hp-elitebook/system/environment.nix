{ pkgs, ... }: {
  environment = with pkgs; {
    shells = [ bash fish nushell ];
    systemPackages = [
      git
      gnupg
      curl
      wget
      aria2
      killall
      htop
      nettools
      inxi
    ];
  };
}
