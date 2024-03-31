{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
#       ./home.nix
    ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/X11
      ../../user/modules/steam
      ../../user/modules/lutris
      ../../system/modules/nvidia
      ../../system/modules/pipewire
      ../../system/modules/networking
      ../../system/modules/virtualization
      ./hardware-configuration.nix
#      ../../system/modules/syncthing
#      ../../system/modules/bluetooth
  ];

    environment.systemPackages = with pkgs; [ 
      gns3-gui
      polkit
      polkit_gnome
    ];

# Noisetorch
programs.noisetorch.enable = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  system.stateVersion = systemSettings.systemstate;
}

