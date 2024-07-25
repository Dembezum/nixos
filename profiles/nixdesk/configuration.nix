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

# -- HYPRLAND --
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

# -- SESSION VARIABLES --
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

# -- GLOBAL VARIABLES --
  environment.sessionVariables = {
    NIX_BUILD_CORES="10";
  };

# -- SERVICES --
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
#  services.ratbagd.enable = true;
  services.flatpak = {
    enable = true;
    packages = [
      "com.usebottles.bottles"
    ];
    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
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


  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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

#  systemd.user.services.polkit-gnome-authentication-agent-1 = {
#    description = "polkit-gnome-authentication-agent-1";
#    wantedBy = [ "graphical-session.target" ];
#    wants = [ "graphical-session.target" ];
#    after = [ "graphical-session.target" ];
#    serviceConfig = {
#      Type = "simple";
#      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
#      Restart = "on-failure";
#      RestartSec = 1;
#      TimeoutStopSec = 10;
#    };
#  };

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

# -- display manager --
  services.xserver.displayManager.gdm = {
      wayland = true;
      enable = true;
      banner = "Wassup swagger";
    };

# -- KEYBOARD --
  services.xserver = {
    enable = true;
    xkb.layout = "dk";
  };

  system.stateVersion = systemSettings.systemstate;
}
