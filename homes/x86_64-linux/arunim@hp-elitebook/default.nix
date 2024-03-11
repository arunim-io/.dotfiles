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

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

    spicetify =
      let
        inherit (inputs.spicetify.packages.${pkgs.system}.default) apps extensions;
      in
      {
        enable = true;
        enabledCustomApps = with apps; [
          marketplace
          lyrics-plus
        ];
        enabledExtensions = with extensions; [
          adblock
          volumePercentage
          fullAlbumDate
        ];
      };
  };
}
