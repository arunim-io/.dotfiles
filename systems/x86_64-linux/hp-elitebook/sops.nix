{
  pkgs,
  config,
  lib,
  ...
}:
let
  username = "arunim";
  homePath = config.snowfallorg.users.${username}.home.path;
in
{
  environment.systemPackages = with pkgs; [ sops ];
  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets.yaml";
    age = {
      keyFile = "${homePath}/.config/sops/age/keys.txt";
      sshKeyPaths = [ config.sops.secrets.ssh_key.path ];
      generateKey = true;
    };
    secrets = {
      github_token.owner = username;
      ssh_key = {
        owner = username;
        path = "${homePath}/.ssh/id_ed25519";
      };
    };
  };

  programs.bash.interactiveShellInit = ''export GITHUB_TOKEN="$(cat /run/secrets/github_token)"'';
}
