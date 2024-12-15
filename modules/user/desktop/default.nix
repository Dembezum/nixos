{ pkgs, ... }:

{
  # Packages to be installed
  home.packages = with pkgs; [
    firefox
    vesktop
    spotify
    nerd-fonts.jetbrains-mono
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];
  fonts.fontconfig.enable = true;
}
