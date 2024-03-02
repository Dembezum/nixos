{ config, lib, pkgs, inputs, ... }:
# modules/hyprland/default.nix

{
#  wayland.windowManager.hyprland = {
#    enable = true;
#  };

  home.packages = with pkgs; [
    gnome.gdm
    rofi-wayland
    libnotify
    dunst
    waybar
    swww
    grimblast
  ];

}

