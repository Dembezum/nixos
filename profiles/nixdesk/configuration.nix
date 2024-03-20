{ systemSettings, userSettings, pkgs, ... }:

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
      ./hardware-configuration.nix
#      ../../system/modules/syncthing
  ];

# Printer
  services.printing.enable = true;

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
    extraGroups = [ "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  #programs.hyprland.enable = true;
  hardware.opengl.enable = true;

#  xdg.portal = {
#    enable = true;
#    extraPortals = [
#      pkgs.xdg-desktop-portal
#      pkgs.xdg-desktop-portal-gtk
#    ];
#  };

xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };

  system.stateVersion = systemSettings.systemstate;
}

