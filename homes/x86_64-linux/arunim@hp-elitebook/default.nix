{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
    ./themes.nix
    ./ags.nix
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };

  programs.neovim.enable = true;
}
