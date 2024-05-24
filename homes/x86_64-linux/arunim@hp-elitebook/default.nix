{ pkgs, inputs, ... }:
{
  mods = {
    home.enable = true;
    theming.enable = true;
    wm.hyprland.enable = true;
    shell = {
      enable = true;
      direnv.enable = true;
      git.enable = true;
      zellij.enable = true;
    };
    apps = {
      firefox.enable = true;
      spotify.enable = true;
      vscode.enable = true;
      nvim.enable = true;
      wezterm.enable = true;
    };
  };

  home = {
    stateVersion = "23.11";

    packages = with pkgs; [
      zoom-us
      brave
      webcord
      topgrade
      bun
      gcc
      gnumake
    ];
  };

  programs.chromium.enable = true;
}
