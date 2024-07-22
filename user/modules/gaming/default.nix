{ config, pkgs, systemSettings, userSettings, ... }:
# -- GAMING CONFIGURATION --

{
  users.users.${userSettings.username}.extraGroups = [ "gamemode" ];

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
      package = pkgs.gamescope;
    };

    gamemode = {
      enable = true; 
      enableRenice = true; 
      settings = {
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        extest.enable = true; # For using Steam Input on Wayland
        extraCompatPackages = [
        pkgs.proton-ge-bin # GloriousEggroll custom Proton
        ];
      gamescopeSession.enable = true;
      protontricks.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
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

  environment = {
    systemPackages = with pkgs; [
      goverlay
        mangohud
        protonup-qt
        glxinfo
        wine
        (prismlauncher.override {
      glfw = pkgs.glfw-wayland-minecraft;
    })
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
