{ inputs, lib, ... }:
{
  environment.etc."nix/inputs/nixpkgs".source = builtins.toString inputs.nixpkgs;

  nix = {
    channel.enable = false;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";

    };
  };
}
