{ config, lib, inputs, pkgs, ... }:
# modules/hyprland/default.nix

{
# Ensure desired packages are available in the user environment.
  home.packages = with pkgs; [
    gnome.gdm
      rofi-wayland
      libnotify
      dunst
      waybar
      swww
  ];

# Xdg portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

# Needed services 
  services = {
    xserver = {
      enable = true; 
      displayManager.gdm.enable = true;
    };

# Gnome stuff
    gnome.gnome-keyring.enable = true;

# Opengl
    hardware = {
      Opengl
        opengl.enable = true;

    }
