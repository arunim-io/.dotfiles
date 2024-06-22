{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hp-elitebook";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Dhaka";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.users.arunim = {
    isNormalUser = true;
    description = "Mugdha Arunim Ahmed";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      sops
      brave
      xfce.thunar
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "24.11";

  programs.hyprland.enable = true;

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

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  sops = {
    defaultSopsFile = lib.snowfall.fs.get-file "secrets.yaml";
    age = {
      keyFile = "/home/arunim/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/arunim/.ssh/id_ed25519" ];
      generateKey = true;
    };
  };
  sops.secrets.github_token.owner = "arunim";
  sops.secrets.ssh_key = {
    owner = "arunim";
    path = "/home/arunim/.ssh/id_ed25519";
  };

  environment.interactiveShellInit = "export GITHUB_TOKEN=$(cat /run/secrets/github_token)";

  programs.ssh.startAgent = true;
  programs.gnupg.agent.enable = true;
}
