{ pkgs, ... }: {
  mods = {
    home.enable = true;
    theming.enable = true;
    wm.hyprland.enable = true;
    shell = {
      enable = true;
      direnv.enable = true;
      git.enable = true;
    };
    apps = {
      vscode.enable = true;
      nvim.enable = true;
    };
  };

  home = {
    stateVersion = "23.11";

    packages = with pkgs; [
      zoom-us
      webcord
      topgrade
      bun
      gcc
      gnumake
    ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
  };
}
