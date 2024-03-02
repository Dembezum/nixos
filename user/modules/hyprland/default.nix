{ config, lib, pkgs, ... }:
# modules/hyprland/default.nix

wayland.windowManager.hyprland = {
  enable = true;

  settings = {
        "$mod" = "SUPER";
    bind =
      [
        "$mod, B, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
  };
};

{
# Ensure desired packages are available in the user environment.
  home.packages = with pkgs; [
    gnome.gdm
      rofi-wayland
      libnotify
      dunst
      waybar
      swww
      grimblast
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
