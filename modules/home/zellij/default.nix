{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.programs.zellij;

  generateAutoStartScript =
    shell:
    let
      cmd = "${getExe cfg.package} setup --generate-auto-start ${type}";
      script = if type == "fish" then "(${cmd} | string collect)" else ''"$(${cmd})"'';
    in
    mkOrder 200 ''eval ${script}'';

  pathType = types.oneOf [
    types.path
    types.string
  ];
in
{
  disabledModules = [ "programs/zellij.nix" ];

  options.programs.zellij = {
    enable = mkEnableOption "zellij";

    package = mkOption {
      type = types.package;
      default = pkgs.zellij;
      defaultText = literalExpression "pkgs.zellij";
      description = "The zellij package to install.";
    };

    enableBashIntegration = mkEnableOption "Bash integration for zellij";
    enableZshIntegration = mkEnableOption "Zsh integration for zellij";
    enableFishIntegration = mkEnableOption "Fish integration for zellij";

    settings = mkOption {
      type = types.nullOr pathType;
      default = null;
    };
    layouts = mkOption {
      type = types.attrsOf pathType;
      default = { };
    };
    themes = mkOption {
      type = types.attrsOf pathType;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs = {
      bash.initExtra = mkIf cfg.enableBashIntegration (generateAutoStartScript "bash");
      zsh.initExtra = mkIf cfg.enableZshIntegration (generateAutoStartScript "zsh");
      fish.interactiveShellInit = mkIf cfg.enableFishIntegration (generateAutoStartScript "fish");
    };

    xdg.configFile =
      {
        "zellij/config.kdl" = mkIf (cfg.settings != null) { source = cfg.settings; };
      }
      // (mkIf (cfg.layouts != { }) (
        mapAttrs' (name: value: nameValuePair "zellij/layouts/${name}.kdl" { source = value; }) cfg.layouts
      ))
      // (mkIf (cfg.themes != { }) (
        mapAttrs' (name: value: nameValuePair "zellij/themes/${name}.kdl" { source = value; }) cfg.themes
      ));
  };
}
