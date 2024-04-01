{ lib, config, pkgs, inputs, system, ... }:

let
  cfg = config.mods.apps.nvim;
in

with lib;

{
  options.mods.apps.nvim = {
    enable = mkOption {
      default = false;
      example = true;
      type = types.bool;
      description = "Whether to configure neovim using home-manager.";
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${system}.neovim;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        # neovim related
        tree-sitter
        fd
        ripgrep
        gcc
        gnumake
        # nix
        nil
        nixpkgs-fmt
        statix
        # lua
        lua-language-server
        selene
        stylua
        # html,css,json
        vscode-langservers-extracted
        emmet-language-server
        # shell
        nodePackages.bash-language-server
        shfmt
        shellcheck
        # dockerfile
        dockerfile-language-server-nodejs
        # python
        python3
        nodePackages.pyright
        ruff
        ruff-lsp
        black
        # javascript
        nodejs_20
        corepack_20
        typescript
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        nodePackages."@astrojs/language-server"
        nodePackages."@tailwindcss/language-server"
        biome
        # multi-lang formatter
        nodePackages.prettier
        # toml
        taplo
        # golang
        go
        gofumpt
        gotools
        golines
        gomodifytags
        gotests
        gotestsum
        iferr
        impl
        reftools
        delve
        ginkgo
        richgo
        gotestsum
        govulncheck
        (callPackage ../../../../packages/go-enum { })
      ];
    };
  };
}
