{ pkgs, systemSettings, userSettings, ... }:
# Nixtop

{
  imports = [
# --- SYSTEM CONFIGURATION ---
    ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/bluetooth
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/pipewire
      ../../system/modules/virtualization
  ];

  environment.systemPackages = with pkgs; [
    gns3-gui
      brightnessctl
  ];

  xdg.portal = { 
    enable = true; 
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk 
        pkgs.xdg-desktop-portal-wlr
    ];
  };

  services.tailscale = {
    enable = true;
  };

  programs.hyprland.enable = true;

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

# -- ZSH --
  programs.zsh.enable = true;

# -- HANDLE DEVICES --
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

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
  
  services.xserver.videoDrivers = ["modesetting"];

  services.tftpd = {
    enable = true;
    path = "/srv/tftp";
  };

  services.fwupd.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "dk"; 
  services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];


#  services.tlp = {
#    enable = true;
#    settings = {
#      CPU_SCALING_GOVERNOR_ON_AC = "performance";
#      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
#
#      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
#
#      CPU_MIN_PERF_ON_AC = 0;
#      CPU_MAX_PERF_ON_AC = 100;
#      CPU_MIN_PERF_ON_BAT = 0;
#      CPU_MAX_PERF_ON_BAT = 80;
#    };
#  };
  system.stateVersion = systemSettings.systemstate;
}
