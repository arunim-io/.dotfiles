{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
    ./themes.nix
    ./ags.nix
    ./neovim.nix
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      vlc
    ];

    sessionPath = [ "$HOME/go/bin" ];
  };

  programs.go.enable = true;
}
