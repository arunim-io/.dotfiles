{ pkgs, config, ... }:
{
  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      luajit
      gnumake
      unzip
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  programs = {
    git = {
      enable = true;
      userName = "Mugdha Arunim Ahmed";
      userEmail = "mugdhaarunimahmed2017@gmail.com";
      extraConfig = {
        gpg.format = "ssh";
      };
      signing = {
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = false;
      withRuby = false;
      extraPackages = with pkgs; [
        nil
        taplo
        lua-language-server
        biome
        prettierd
        stylua
        nixfmt-rfc-style
        statix
        selene
        ripgrep
        fd
        fzf
        wl-clipboard
        gcc
      ];
    };

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "JetBrainsMono NF";
          box-drawings-uses-font-glyphs = true;
          dpi-aware = true;
          bold-text-in-bright = true;
        };
        mouse.hide-when-typing = true;
        key-bindings.fullscreen = "F11";
      };
    };

    fish = {
      enable = true;
      shellInitLast = ''
        bind \b backward-kill-word
        bind \e\[3\;5~ kill-word
      '';
      plugins = with pkgs; [
        {
          name = "sponge";

          inherit (fishPlugins.sponge) src;
        }
        {
          name = "autopair";

          inherit (fishPlugins.autopair) src;
        }
        {
          name = "puffer";

          inherit (fishPlugins.puffer) src;
        }
      ];
    };

    zellij.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship.enable = true;
    zoxide.enable = true;
    bat.enable = true;

    wofi.enable = true;
    lazygit.enable = true;
  };

  xdg.configFile."zellij/config.kdl".source = ./configs/zellij.kdl;
}
