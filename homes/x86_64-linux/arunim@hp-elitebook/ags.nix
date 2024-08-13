{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    esbuild
    brightnessctl
  ];

  programs.ags = {
    enable = true;
    configDir = builtins.toString (lib.internal.get-config-path "ags");
  };
}
