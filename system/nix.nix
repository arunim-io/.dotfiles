{
  inputs,
  lib,
  username,
  ...
}:
{
  environment.etc."nix/inputs/nixpkgs".source = builtins.toString inputs.nixpkgs;

  nix = {
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      nix-path = lib.mkForce "nixpkgs=${inputs.nixpkgs}";
    };
  };

  programs.nh = {
    enable = true;
    flake = "/home/${username}/.dotfiles";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
