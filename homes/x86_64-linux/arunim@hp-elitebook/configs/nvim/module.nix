{ inputs }:
{ pkgs, ... }:
{
  config = {
    home.sessionPath = [ "$HOME/go/bin" ];

    programs = {
      go.enable = true;

      neovim = {
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        withPython3 = false;
        withRuby = false;
        withNodeJs = true;
        extraPackages =
          let
            LSPkgs = with pkgs; [
              # nix
              nil
              nixfmt-rfc-style
              statix
              # lua
              lua-language-server
              selene
              stylua
              # html,css,json
              vscode-langservers-extracted
              emmet-language-server
              # shell
              bash-language-server
              shfmt
              shellcheck
              # dockerfile
              dockerfile-language-server-nodejs
              # python
              python3
              basedpyright
              ruff
              # javascript
              nodejs_20
              corepack_20
              typescript
              svelte-language-server
              typescript-language-server
              astro-language-server
              tailwindcss-language-server
              typescript
              # multi-lang formatter
              prettierd
              biome
              # toml
              taplo
              # yaml
              yaml-language-server
              # go
              gopls
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
            ];

            systemPkgs = with pkgs; [
              ripgrep
              fd
              fzf
              wl-clipboard
              gcc
              luajit
              gnumake
              unzip
              xdg-utils
            ];
          in
          systemPkgs ++ LSPkgs;
      };
    };
  };
}
