{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [
      nil
      taplo
      lua-language-server
      biome
      prettierd
      stylua
      nixfmt-rfc-style
      statix
      selene
      ripgrep
      fd
      fzf
      wl-clipboard
      gcc
      luajit
      gnumake
      unzip
    ];
  };
}
