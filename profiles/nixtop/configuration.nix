{ config, pkgs, lib, systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
       ./hardware-configuration.nix
      ../../system/region
      ../../universal.nix
      ../../system/modules/networking
      ../../system/modules/X11
      ../../system/modules/bluetooth
      ../../system/modules/pipewire
# --- USER CONFIGURATION ---
      ../../user/modules/tmux
      ../../user/modules/kitty
      ../../user/modules/neovim
      ../../user/modules/shells
#   ../../../user/modules/hyprland
#    ../../../user/modules/normie
#   ../../../user/modules/gnome
#   ../../../user/modules/kde
# ../../../user/modules/gtk
      ./home.nix
  ];

# Printer
  services.printing.enable = true;

# Nix options.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "video" "networkmanager" "wheel" ];
    uid = 1000;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  system.stateVersion = "23.11";
}

