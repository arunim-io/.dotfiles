{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./foot.nix
    ./cmdline.nix
  ];
  home = {
    stateVersion = "24.11";
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };

  programs.wofi.enable = true;
}
