{ pkgs, ... }:
{
  home.packages = with pkgs; [
    esbuild
    brightnessctl
  ];

  programs.ags.enable = true;
}
