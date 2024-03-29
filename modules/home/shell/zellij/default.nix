{ lib, config, inputs, system, ... }:

let
  cfg = config.mods.shell.zellij;
in

with lib;

{
  options.mods.shell.zellij = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure zellij using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    home.file = {
      "./.config/zellij/config.kdl".text = ''
        simplified_ui true

        keybinds {
          normal clear-defaults=true {
            unbind "Ctrl b"
            bind "Ctrl f" { SwitchToMode "Tmux"; }

            bind "Alt n" { NewPane; }
            bind "Alt x" { CloseFocus; SwitchToMode "Normal"; }
            bind "Alt w" { ToggleFloatingPanes; }
            bind "Alt t" { NewTab; }
            bind "Alt Left" { MoveFocus "Left"; }
            bind "Alt Right" { MoveFocus "Right"; }
            bind "Alt Down" { MoveFocus "Down"; }
            bind "Alt Up" { MoveFocus "Up"; }
            bind "Alt `" { GoToNextTab; }
            bind "Alt =" { Resize "Increase"; } // zellij wasn't recoginizing + so I had to use =
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }
            bind "%" { NewPane "Right"; SwitchToMode "Normal"; }
            bind "\"" { NewPane "Down"; SwitchToMode "Normal"; }
          }
          tmux clear-defaults=true {
            bind "Ctrl f" { Write 2; SwitchToMode "Normal"; }
            bind "Esc" { SwitchToMode "Normal"; }
            bind "l" { SwitchToMode "Locked"; }
            bind "p" { SwitchToMode "Pane"; }
            bind "t" { SwitchToMode "Tab"; }
            bind "r" { SwitchToMode "Resize"; }
            bind "m" { SwitchToMode "Move"; }
            bind "s" { SwitchToMode "Scroll"; }
            bind "o" { SwitchToMode "Session"; }
          }
        }
      '';
      "./.config/zellij/layouts/default.kdl".text = ''
        layout {
          default_tab_template {
            pane size=1 borderless=true {
              plugin location="file:${inputs.zjstatus.packages.${system}.default}/bin/zjstatus.wasm" {
                format_left   "{mode} #[fg=#89B4FA,bold]{session} {tabs}"
                format_center ""
                format_right  "{command_git_branch}"
                format_space  ""

                border_enabled "false"
                hide_frame_for_single_pane "true"

                mode_normal  "#[bg=blue] "
                mode_tmux    "#[bg=#ffc387] "

                tab_normal   "#[fg=#6C7086] {name} "
                tab_active   "#[fg=#9399B2,bold,italic] {name} "

                command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                command_git_branch_format      "#[fg=blue] {stdout} "
                command_git_branch_interval    "10"
                command_git_branch_rendermode  "static"
              }
            }
            children
            pane size=2 borderless=true {
              plugin location="zellij:status-bar"
            }
          }
        }
      '';
    };
  };
}
