{ pkgs, inputs, ... }:
{
  imports = [
    ./git.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
    ./themes.nix
    ./ags.nix
    (import ./configs/nvim/module.nix { inherit inputs; })
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      vlc
    ];
  };

  programs.neovim.enable = true;
}
