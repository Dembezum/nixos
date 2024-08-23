{ pkgs, systemSettings, userSettings, ... }:
# Nixdesk

{
  imports = [
    # --- SYSTEM CONFIGURATION ---
    ../../universal.nix
    ../../modules/system/ssh
    ../../modules/system/nvidia
    ../../modules/system/pipewire
    ../../modules/system/virtualization
    ../../modules/system/ssh
    ../../modules/user/gaming
    ./hardware-configuration.nix
  ];

  # -- PACKAGES -- 
  environment.systemPackages = with pkgs; [
    xwayland
    #xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    appimage-run
    #    gns3-gui
    putty
    jdk21
    mpv
  ];

  security = { rtkit.enable = true; };

  programs = {
    # -- HYPRLAND --
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # -- GNUPKG --
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # -- ZSH --
    zsh = { enable = true; };
  };

  # -- SESSION VARIABLES --
  environment.sessionVariables = {
    NIX_BUILD_CORES = "6";
    NIXOS_OZONE_WL = "1";
  };

  # -- SERVICES --
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
    dbus.enable = true;
    lldpd.enable = true;
    gnome = { gnome-keyring.enable = true; };
    #  services.ratbagd.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "dk";
      displayManager.gdm = {
        wayland = true;
        enable = true;
        banner = "Wassup swagger";
      };
    };
    #    flatpak = {
    #      enable = true;
    #      packages = [ "com.usebottles.bottles" ];
    #      update = {
    #        onActivation = true;
    #        auto = {
    #          enable = true;
    #          onCalendar = "daily";
    #        };
    #      };
    #    };
  };

  # -- XDG --
  xdg.portal = {
    enable = true;
    extraPortals = [
      #      pkgs.xdg-desktop-portal-gtk 
      #        pkgs.xdg-desktop-portal-wlr
      #        pkgs.xdg-desktop-portal-hyprland
    ];
  };

  xdg.portal.config = {
    common = {
      default = [ "hyprland" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
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
  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 8001 3306 53317 22 443 8384 22000 61208 61209 ];
    allowedUDPPorts = [ 22000 53317 21027 61208 ];

  };

  system.stateVersion = systemSettings.systemstate;
}
