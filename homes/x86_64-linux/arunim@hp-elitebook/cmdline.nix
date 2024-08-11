{ pkgs, ... }:
{
  programs = {
    fish = {
      enable = true;
      shellInitLast = ''
        bind \b backward-kill-word
        bind \e\[3\;5~ kill-word
      '';
      plugins = with pkgs; [
        {
          name = "sponge";

          inherit (fishPlugins.sponge) src;
        }
        {
          name = "autopair";

          inherit (fishPlugins.autopair) src;
        }
        {
          name = "puffer";

          inherit (fishPlugins.puffer) src;
        }
      ];
    };

    zellij.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship.enable = true;
    zoxide.enable = true;
    bat.enable = true;
  };

  xdg.configFile."zellij".source = ./configs/zellij;
}
