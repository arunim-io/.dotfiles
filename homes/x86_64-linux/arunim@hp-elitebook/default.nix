{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
  ];
  home = {
    stateVersion = "24.11";
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };
}
