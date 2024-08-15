{
  inputs,
  system,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    imagemagick
    wl-clipboard
  ];
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${system}.default;
    enableFishIntegration = true;
    settings.yazi.manager = {
      show_hidden = true;
      show_dir_first = false;
    };
  };
}
