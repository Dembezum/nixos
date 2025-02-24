{ pkgs, systemSettings, userSettings, ... }:
# Nixdesk

{
  imports = [
    # --- SYSTEM CONFIGURATION ---
    ../../universal.nix
    ../../modules/system/ssh
    ../../modules/system/udev
    #    ../../modules/system/keyd
    ../../modules/user/gaming
    ../../modules/system/nvidia
    ../../modules/system/glances
    ../../modules/system/rsyslog
    ../../modules/system/openrgb
    ../../modules/system/pipewire
    ../../modules/system/bluetooth
    ../../modules/system/virtualization
    ./hardware-configuration.nix
  ];

  hardware.spacenavd.enable = true;

  #  hardware.keyboard.qmk.enable = true;

  # -- PACKAGES -- 
  environment.systemPackages = with pkgs; [
    # VPN 
    openfortivpn
    mono
    openssl
    wine-wayland
    bluez
    xwayland
    xdg-desktop-portal
    #    xdg-desktop-portal-gtk
    #    xdg-desktop-portal-wlr
    appimage-run
    prusa-slicer
    orca-slicer
    putty
    jdk21
    kicad
    mpv
    piper
    spacenavd
    #    gns3-gui
  ];

  security = { rtkit.enable = true; };
  security = { sudo.enable = true; };

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
    NIX_BUILD_CORES = "10";
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
    flatpak = {
      enable = true;
      packages = [ "com.usebottles.bottles" ];
      update = {
        onActivation = true;
        auto = {
          enable = true;
          onCalendar = "daily";
        };
      };
    };
    desktopManager.plasma6.enable = true;
  };

  # -- XDG --
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-hyprland
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
    extraGroups = [
      "dialout"
      "input"
      "docker"
      "plugdev"
      "libvirt"
      "video"
      "networkmanager"
      "wheel"

    ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  #  systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 2021 8080 8001 3306 53317 22 443 8384 22000 ];
    allowedUDPPorts = [ 2021 22000 53317 21027 61208 ];

  };

  system.stateVersion = systemSettings.systemstate;
}
