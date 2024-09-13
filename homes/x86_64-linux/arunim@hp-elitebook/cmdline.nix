{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [ comma ];

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

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship.enable = true;
    zoxide.enable = true;
    bat.enable = true;

    zellij = {
      enable = true;
      settings = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zellij/config.kdl";
      layouts.default = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/zellij/layouts/default.kdl";
    };

    tmux = {
      enable = true;
      shell = lib.getExe config.programs.fish.package;
      terminal = "tmux-256color";
      keyMode = "vi";
      prefix = "M-a";
      mouse = true;
      escapeTime = 0;
      historyLimit = 10000;
      baseIndex = 1;
      extraConfig = builtins.readFile "${inputs.self}/configs/tmux/tmux.conf";
      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        yank
        fzf-tmux-url
      ];
    };
  };
}
