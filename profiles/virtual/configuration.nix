{ systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
#       ./home.nix
       ./hardware-configuration.nix
      ../../universal.nix
      ../../system/modules/networking
      ../../system/modules/X11
      ../../system/modules/bluetooth
      ../../system/modules/pipewire
#      ../../system/modules/virtualization
# --- USER CONFIGURATION ---
#      ../../user/modules/tmux
#      ../../user/modules/kitty
#      ../../user/modules/neovim
#      ../../user/modules/shells
#   ../../../user/modules/hyprland
#    ../../../user/modules/normie
#   ../../../user/modules/gnome
#   ../../../user/modules/kde
# ../../../user/modules/gtk
  ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  hardware.opengl.enable = true;

#  xdg.portal = {
#    enable = true;
#    extraPortals = [
#      pkgs.xdg-desktop-portal
#      pkgs.xdg-desktop-portal-gtk
#    ];
#  };

  system.stateVersion = systemSettings.systemstate;
}

