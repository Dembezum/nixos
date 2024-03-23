{ lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
#       ./home.nix
    ../../universal.nix
      ../../system/modules/X11
      ../../system/modules/nvidia
      ../../system/modules/networking
      ../../system/modules/bluetooth
      ../../system/modules/pipewire
      ../../system/modules/ssh
      ../../system/modules/virtualization
      ../../user/modules/steam
      ../../user/modules/lutris
      ./hardware-configuration.nix
#      ../../system/modules/syncthing
  ];

#    programs.nix-ld.enable = true;
    services.envfs.enable = true;

# Printer
#  services.printing.enable = true;

hardware.nvidia.forceFullCompositionPipeline = true;
environment.localBinInPath = true;

# Nix options.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  #programs.hyprland.enable = true;

#  xdg.portal = {
#    enable = true;
#    extraPortals = [
#      pkgs.xdg-desktop-portal
#      pkgs.xdg-desktop-portal-gtk
#    ];
#  };

  system.stateVersion = systemSettings.systemstate;
}

