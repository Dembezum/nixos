{ pkgs, ... }:

{
# Packages to be installed
  home.packages = with pkgs; [
    firefox
      vesktop
      spotify
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;
}
