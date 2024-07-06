{ pkgs, ... }:
{
  home.packages = with pkgs; [ esbuild ];

  programs.ags.enable = true;
}
