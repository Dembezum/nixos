{ pkgs, systemSettings, userSettings, ... }:
# Nixtop

{
  imports = [
# --- SYSTEM CONFIGURATION ---
      ../../universal.nix
      ../../system/modules/X11
      ../../system/modules/ssh
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/pipewire
      ../../system/modules/virtualization
  ];

  environment.systemPackages = with pkgs; [
    gns3-gui
    brightnessctl
  ];

  xdg.portal = { 
    enable = true; 
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk 
        pkgs.xdg-desktop-portal-wlr
    ];
  };

  programs.hyprland.enable = true;
  xdg.portal.config = {
    common = {
      default = [
        "wlr"
      ];
      "org.freedesktop.impl.portal.Secret" = [
        "gnome-keyring"
      ];
    };
  };

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

system.stateVersion = systemSettings.systemstate;
}
