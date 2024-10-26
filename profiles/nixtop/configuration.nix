{ pkgs, systemSettings, userSettings, ... }:
# Nixtop

{
  imports = [
    # --- SYSTEM CONFIGURATION ---
    ../../universal.nix
    ../../modules/system/ssh
    ../../modules/system/bluetooth
    ../../modules/system/rsyslog
    ../../modules/system/keyd
    ./hardware-configuration.nix
    ../../modules/system/networking
    ../../modules/system/pipewire
  ];

  environment.systemPackages = with pkgs; [ gns3-gui brightnessctl ];

  xdg.portal = {
    enable = true;
    extraPortals =
      [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
  };

  programs.hyprland.enable = true;

  xdg.portal.config = {
    common = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };

  # -- ZSH --
  programs.zsh.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  hardware.graphics = { enable = true; };

  services = {
    tailscale.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    dbus.enable = true;
    lldpd.enable = true;
    gnome = { gnome-keyring.enable = true; };
    ratbagd.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "dk";
      displayManager.gdm = {
        wayland = true;
        enable = true;
        banner = "Wassup swagger";
      };
    };
    desktopManager.plasma6.enable = true;
  };

  system.stateVersion = systemSettings.systemstate;
}
