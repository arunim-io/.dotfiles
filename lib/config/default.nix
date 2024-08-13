{ lib, ... }:
let
  configDir = ../../configs;
in
{
  get-config-path =
    target:
    let
      path = builtins.concatStringsSep "/" [
        configDir
        target
      ];
    in
    if builtins.pathExists path then path else lib.warn "Config path not found!" path;
}
