{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      plugins = with pkgs; [
        {
          name = "sponge";
          src = fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
            hash = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        }
        {
          name = "autopair";
          src = fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
            hash = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
          };
        }
        {
          name = "puffer-fish";
          src = fetchFromGitHub {
            owner = "nickeb96";
            repo = "puffer-fish";
            rev = "5d3cb25e0d63356c3342fb3101810799bb651b64";
            hash = "sha256-aPxEHSXfiJJXosIm7b3Pd+yFnyz43W3GXyUB5BFAF54=";
          };
        }
      ];
    };
    starship.enable = true;
    zoxide.enable = true;
    bat.enable = true;
  };
}
