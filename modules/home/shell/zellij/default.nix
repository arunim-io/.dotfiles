{
  lib,
  config,
  inputs,
  system,
  ...
}:

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
      "./.config/zellij/config.kdl".source = ./config.kdl;
      "./.config/zellij/layouts/default.kdl".text = ''
        layout {
          default_tab_template {
            pane size=1 borderless=true {
              plugin location="file:${inputs.zjstatus.packages.${system}.default}/bin/zjstatus.wasm" {
                format_left "{mode} #[fg=#89B4FA,bold]{session} | {tabs}"

                border_enabled "false"

                mode_normal "#[bg=blue] "
                mode_tmux   "#[bg=#ffc387] "

                tab_normal "#[fg=#6C7086] {name} "
                tab_active "#[fg=#9399B2,bold,italic] {name} "
              }
            }
            children
            pane size=2 borderless=true {
              plugin location="zellij:status-bar"
            }
          }
        }
      '';
      "./.config/zellij/layouts/default.swap.kdl".source = ./swap-layout.kdl;
    };
  };
}
