_: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = "source ~/.config/direnv/layout_poetry.sh";
  };

  home.file.direnv-layout-poetry = {
    source = ./layout_poetry.sh;
    target = "./.config/direnv/layout_poetry.sh";
  };
}
