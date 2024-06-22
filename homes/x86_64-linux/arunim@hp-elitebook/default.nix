{ pkgs, config, ... }:
{
  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    userName = "Mugdha Arunim Ahmed";
    userEmail = "mugdhaarunimahmed2017@gmail.com";
    extraConfig = {
      gpg.format = "ssh";
    };
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  programs.wofi.enable = true;
  programs.foot.enable = true;
  programs.lazygit.enable = true;
}
