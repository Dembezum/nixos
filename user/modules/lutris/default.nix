{ pkgs, ... }:

let
  winePackages = pkgs.winePackages.stable;
in
{
  home.packages = with pkgs; [
    lutris
    wineasio
    winetricks
    winePackages # Note: This assumes you want the stable wine packages
  ];
}

