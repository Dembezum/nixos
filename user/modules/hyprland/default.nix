{ config, lib, pkgs, inputs, ... }:
# modules/hyprland/default.nix

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = false;
  };
  
  home.packages = with pkgs; [
    gnome.gdm
      rofi-wayland
      libnotify
      dunst
      drm_info
      waybar
      swww
      wlroots
      wl-clipboard
      wdisplay
      wlr-randr
      xdg-desktop-portal-wlr
      grimblast
  ];

}
