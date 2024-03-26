{ pkgs, inputs, ... }: {
  imports = with inputs; [
    ags.homeManagerModules.default
    spicetify.homeManagerModule
  ];

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
      firefox.enable = true;
      vscode.enable = true;
      nvim.enable = true;
      spotify.enable = true;
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
}
