{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim.url = "github:arunim-io/nvim";
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    inputs:
    let
      systemName = "hp-elitebook";
      system = "x86_64-linux";
      username = "arunim";

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = with inputs; [ hyprcontrib.overlays.default ];
      };

      passthru = {
        inherit inputs system;
      };
    in
    {
      nixosConfigurations.${systemName} = inputs.nixpkgs.lib.nixosSystem {
        inherit pkgs;

        specialArgs = passthru // {
          inherit username;
        };

        modules = with inputs; [
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          }
          ./system
          nix-index-database.nixosModules.nix-index
          sops.nixosModules.sops
          hyprland.nixosModules.default
        ];
      };

      homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = passthru;

        modules = with inputs; [
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };

            programs.home-manager.enable = true;
          }
          ./home
          nix-index-database.hmModules.nix-index
          hyprland.homeManagerModules.default
          ags.homeManagerModules.default
          nvim.homeManagerModules.default
        ];
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://arunim.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "arunim.cachix.org-1:J07zWDguRFHQSio/VmTT8us5EelRNlDTFkbNeFel0xM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };
}
