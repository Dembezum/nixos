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
    gns3-gui
    jdk21
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

# Gaming
  gamemode = {
    enable = true; 
    enableRenice = true; 
    settings = {
    };
  };



# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "gamemode" "plugdev" "libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
    shell = pkgs.zsh;
    programs = {
      gamescope = {
        enable = true;
      };
      gamemode = {
        enable = true; 
        enableRenice = true; 
        settings = {
        };
      };
    };
  };

    systemd.services.NetworkManager-wait-online.enable = false;

    services.lldpd.enable = true;

    networking.networkmanager.enable = true;
    networking.hostName = systemSettings.hostname;

# Firewall
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 3306 53317 22 443 8384 22000 61208 61209];
      allowedUDPPorts = [ 22000 53317 21027 61208 ];

    };

    services.xserver.enable = true;
    services.xserver.xkb.layout = "dk"; 
    services.xserver.displayManager.gdm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.videoDrivers = [ "nvidia" "modesetting" ];

    system.stateVersion = systemSettings.systemstate;
  }
