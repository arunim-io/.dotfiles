{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    esbuild
    brightnessctl
  ];

  programs.ags.enable = true;

  xdg.configFile.ags.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/ags/";
}
