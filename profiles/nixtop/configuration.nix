{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
#       ./home.nix
      ../../universal.nix
      ../../system/modules/X11
      ../../system/modules/ssh
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/pipewire
      ../../system/modules/virtualization
#      ../../system/modules/bluetooth
#      ../../system/modules/syncthing
# --- USER CONFIGURATION ---
#      ../../user/modules/steam
#      ../../user/modules/tmux
#      ../../user/modules/kitty
#      ../../user/modules/neovim
#      ../../user/modules/shells
#   ../../../user/modules/hyprland
#    ../../../user/modules/normie
#   ../../../user/modules/gnome
#   ../../../user/modules/kde
# ../../../user/modules/gtk
  ];

# Printer
#  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    gns3-gui
  ];

# Nix options.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = ["libvirt" "video" "networkmanager" "wheel" ];
    uid = 1000;
  };
#  programs.hyprland.enable = true;
#hardware.opengl.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };



#xdg.portal = {
#  enable = true;
#  extraPortals = [
#    pkgs.xdg-desktop-portal
#    pkgs.xdg-desktop-portal-gtk
#  ];
#};

system.stateVersion = systemSettings.systemstate;
}
