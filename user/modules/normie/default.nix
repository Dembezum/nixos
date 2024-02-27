{ config, pkgs, ... }:

{
# Packages to be installed
  home.packages = with pkgs; [
      firefox
      discord
      spotify
  ];
}
