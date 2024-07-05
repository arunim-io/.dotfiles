{
  pkgs,
  inputs,
  system,
  ...
}:
{
  imports = [
    ./git.nix
    ./foot.nix
    ./cmdline.nix
    ./hyprland.nix
    ./themes.nix
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };
  programs = {
    ags = {
      enable = true;
      package = inputs.ags-config.packages.${system}.default;
    };

    neovim.enable = true;
  };
}
