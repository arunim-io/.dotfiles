{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "hp-elitebook";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Dhaka";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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
      zoom-us
      pulseaudio
    ];
  };

  nixpkgs.config.allowUnfree = true;

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
    secrets = {
      github_token.owner = "arunim";
      ssh_key = {
        owner = "arunim";
        path = "/home/arunim/.ssh/id_ed25519";
      };
    };
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  programs.bash.interactiveShellInit = # bash
    ''
      export GITHUB_TOKEN="$(cat /run/secrets/github_token)"

      # The code below executes fish using bash. See https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell for more info.
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';

  programs.ssh.startAgent = true;
  programs.gnupg.agent.enable = true;
}
