{ pkgs, ... }: {
  home.packages = with pkgs; [ act ];

  programs = {
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "mugdhaarunimahmed2017@gmail.com";
      userName = "Mugdha Arunim Ahmed";
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        editor = "nvim";
        pager = "nvim +Man!";
      };
    };

    lazygit.enable = true;
  };
}
