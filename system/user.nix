{ pkgs, ... }:
let
  username = "arunim";
in
{

  users.users.${username} = {
    isNormalUser = true;
    description = "Mugdha Arunim Ahmed";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    packages = with pkgs; [
      brave
      zoom-us
    ];
  };

  nix.settings.trusted-users = [ username ];

  environment.systemPackages = with pkgs; [ git ];

  programs = {
    ssh.startAgent = true;
    gnupg.agent.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
      ];
    };

    xfconf.enable = true;

    file-roller.enable = true;
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
  };
}
