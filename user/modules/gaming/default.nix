{ config, pkgs, systemSettings, userSettings, ... }:
# -- GAMING CONFIGURATION --

{
  users.users.${userSettings.username}.extraGroups = [ "gamemode" ];
    programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    gamemode = {
      enable = true; 
      enableRenice = true; 
      settings = {
      };
    };

    steam = {
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
        wine
        prismlauncher
        vulkan-tools

    (lutris.override {
       extraPkgs = pkgs: [
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
    })
  ];
  };

  
}
