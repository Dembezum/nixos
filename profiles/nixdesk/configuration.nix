{ pkgs, systemSettings, userSettings, ... }:
# Nixdesk

{
  imports = [
# --- SYSTEM CONFIGURATION ---
    ../../universal.nix
      ../../system/modules/ssh
      ../../user/modules/gaming
      ../../system/modules/nvidia
      ../../system/modules/pipewire
      ../../system/modules/virtualization
      ./hardware-configuration.nix
  ];

# -- PACKAGES -- 
  environment.systemPackages = with pkgs; [ 
    appimage-run
    putty
    gns3-gui
    jdk21
    mpv
  ];

# -- HYPRLAND --
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

# -- File management --
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

# -- XDG --
  xdg.portal = { 
    enable = true; 
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk 
        pkgs.xdg-desktop-portal-wlr
    ];
  };
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
    shell = pkgs.zsh;
  };

#  systemd.services.NetworkManager-wait-online.enable = false;
  services.lldpd.enable = true;
  networking.networkmanager.enable = true;
  networking.hostName = systemSettings.hostname;

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 8001 3306 53317 22 443 8384 22000 61208 61209];
    allowedUDPPorts = [ 22000 53317 21027 61208 ];

  };

  services.desktopManager.plasma6.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "dk";
  };

  system.stateVersion = systemSettings.systemstate;
}
