{
  pkgs,
  inputs,
  config,
  ...
}:
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
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/homes/x86_64-linux/arunim@hp-elitebook/configs/nvim/";
}
