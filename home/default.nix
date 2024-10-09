{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
    ./themes.nix
    ./ags.nix
    ./yazi.nix
    ./tmux.nix
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      xdg-utils
      vlc
      loupe
    ];

    sessionPath = [ "$HOME/go/bin" ];
  };

  programs.go.enable = true;

  anc.enable = true;
}
