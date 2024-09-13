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
        {
          plugin = mkTmuxPlugin rec {
            pluginName = "nvim";
            version = src.rev;
            src = pkgs.fetchFromGitHub {
              owner = "aserowy";
              repo = "tmux.nvim";
              rev = "65ee9d6e6308afcd7d602e1320f727c5be63a947";
              hash = "sha256-ltot+gFsIWpPR5/IKb/wHHrgALVYkpHr8yhM2jlmaxg=";
            };
            rtpFilePath = "tmux.nvim.tmux";
          };
          extraConfig = ''
            set -g @tmux-nvim-navigation-keybinding-left 'C-Left'
            set -g @tmux-nvim-navigation-keybinding-down 'C-Down'
            set -g @tmux-nvim-navigation-keybinding-up 'C-Up'
            set -g @tmux-nvim-navigation-keybinding-right 'C-Right'

            set -g @tmux-nvim-resize-keybinding-left 'M-Left'
            set -g @tmux-nvim-resize-keybinding-down 'M-Down'
            set -g @tmux-nvim-resize-keybinding-up 'M-Up'
            set -g @tmux-nvim-resize-keybinding-right 'M-RIght'
          '';
        }
      ];
    };
  };
}
