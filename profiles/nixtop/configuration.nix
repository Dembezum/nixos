{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
      ../../universal.nix
      ../../system/modules/X11
      ../../system/modules/ssh
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/pipewire
      ../../system/modules/nix-settings
      ../../system/modules/virtualization
  ];

  environment.systemPackages = with pkgs; [
    gns4-gui
    brightnessctl
  ];

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
