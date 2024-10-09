{
  pkgs,
  config,
  username,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ sops ];

  sops = {
    defaultSopsFile = "${inputs.self}/secrets.yaml";
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
      sshKeyPaths = [ config.sops.secrets.ssh_key.path ];
      generateKey = true;
    };
    secrets = {
      github_token.owner = username;
      ssh_key = {
        owner = username;
        path = "/home/${username}/.ssh/id_ed25519";
      };
    };
  };

  programs.bash.interactiveShellInit = # sh
    ''
      export GITHUB_TOKEN="$(cat /run/secrets/github_token)"
    '';
}
