{ lib, config, systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
{
  imports = [
    ./dhcpserver.nix
      ../../universal.nix
      ./hardware-configuration.nix
#      ../../system/modules/networking
      ../../system/modules/ssh
  ];

  environment.systemPackages = [ 
    pkgs.tailscale 
  ];


  boot.loader.grub = {
	  enable = true;
	  device = "/dev/sda";
	  useOSProber = true;
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  system.stateVersion = systemSettings.systemstate;
}
