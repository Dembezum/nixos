{ config, pkgs, systemSettings, userSettings, ... }:
# -- GAMING CONFIGURATION --

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
      ];
    };
  };

hardware = {
  opengl.enable = true; 
};

environment = {
  systemPackages = with pkgs; [
    goverlay
      mangohud
      protonup-qt
      glxinfo
      lutris
      prismlauncher
  ];
};

}
