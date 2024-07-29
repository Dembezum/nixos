{ pkgs, systemSettings, userSettings, ... }:
# zumserve

{
  imports = [
# --- SYSTEM CONFIGURATION ---
    ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/virtualization
      ./hardware-configuration.nix
  ];

# -- PACKAGES -- 
  environment.systemPackages = with pkgs; [ 
    appimage-run
    mpv
  ];

  programs.zsh.enable = true;

# -- File management --
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

  services.lldpd.enable = true;
  networking.networkmanager.enable = true;
  networking.hostName = systemSettings.hostname;

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [  22 61208 61209];
    allowedUDPPorts = [ 22000 53317 21027 61208 ];

  };

  services.xserver = {
    enable = true;
    xkb.layout = "dk";
  };

  system.stateVersion = systemSettings.systemstate;
}
