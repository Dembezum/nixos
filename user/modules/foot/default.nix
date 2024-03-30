{pkgs, ...}: let
  catppuccinDrv = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  theme = import ../lib/theme {};
  inherit (theme.terminal) font fontItalic size opacity;
in {
  programs.foot = {
    enable = true;
    settings = {
      main = let
        withSize = "size=${toString size}";
      in {
        font = "${font}:${withSize}";
        font-bold = "${font}:style=Bold:${withSize}";
        font-italic = "${fontItalic}:style=Italic:${withSize}";
        font-bold-italic = "${fontItalic}:style=BoldItalic:${withSize}";
        box-drawings-uses-font-glyphs = true;
        include = "${catppuccinDrv}";
      };

      scrollback = {
        lines = 10000;
      };

      url = {
        launch = "xdg-open \${url}";
        protocols = "http, https, ftp, ftps, file";
      };

      colors = {
        alpha = opacity;
      };
    };
  };
}
