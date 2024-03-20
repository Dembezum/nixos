{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
#      wineasio # Cross-Platform
#      winetricks # Cross-Platform
#      wineWowPackages.stable # Cross-Platform
  ];
}
