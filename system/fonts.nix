{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = with pkgs; [
      font-awesome
      material-design-icons
      ubuntu_font_family
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "UbuntuMono"
        ];
      })
    ];

    fontconfig = {
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [
          "Ubuntu"
          "Noto Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
        sansSerif = [
          "Ubuntu"
          "Noto Sans"
        ];
        monospace = [
          "JetBrains Nerd Font"
          "Ubuntu Mono"
          "Noto Color Emoji"
        ];
      };
    };
  };
}
