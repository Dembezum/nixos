{ config, pkgs, systemSettings, userSettings, ... }:

# -- STEAM CONFIGURATION --
# Steam is needed to be install on the system profile. That's just how it is
# apparently.
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

# Packages to be installed
environment.systemPackages = with pkgs; [
  glxinfo
  steam
  ];
}

