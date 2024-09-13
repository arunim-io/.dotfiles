{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [ tmux-sessionizer ];

  xdg.configFile."tms/config.toml".source = (pkgs.formats.toml { }).generate "tms-config" {
    search_dirs = [
      {
        path = "/home/arunim/.dotfiles/";
        depth = 1;
      }
      {
        path = "/home/arunim/Projects/";
        depth = 2;
      }
    ];
  };

  programs.tmux = {
    enable = true;
    shell = lib.getExe config.programs.fish.package;
    terminal = "tmux-256color";
    keyMode = "vi";
    prefix = "M-a";
    mouse = true;
    escapeTime = 0;
    historyLimit = 10000;
    baseIndex = 1;
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
    extraConfig =
      let
        tms = lib.getExe pkgs.tmux-sessionizer;
      in
      ''
        set -sa terminal-overrides ",xterm*:Tc"

        set -g status-position top
        set -g status-style "bg=black,fg=white"

        set -g detach-on-destroy off

        set -g pane-base-index 1
        set -g renumber-windows on

        unbind %
        unbind '"'
        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"
        bind t new-window -c "#{pane_current_path}"

        unbind p
        unbind n
        bind [ previous-window
        bind ] next-window

        bind q kill-pane

        bind c copy-mode
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        bind t display-popup -E "${tms} switch"
        set -ga status-right " #(${tms} sessions)"
      '';
  };
}
