{ config, ... }:
{
  programs = {
    lazygit.enable = true;
    git = {
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
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
