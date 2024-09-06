{ lib, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      shell = lib.getExe pkgs.fish;
      main = {
        font = "JetBrainsMono NF";
        box-drawings-uses-font-glyphs = true;
        dpi-aware = true;
        bold-text-in-bright = true;
      };
      mouse.hide-when-typing = true;
      key-bindings.fullscreen = "F11";
    };
  };
}
