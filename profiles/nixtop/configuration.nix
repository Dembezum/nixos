{ systemSettings, userSettings, ... }:

{
  imports = [
# --- SYSTEM CONFIGURATION ---
#       ./home.nix
       ./hardware-configuration.nix
      ../../universal.nix
      ../../system/modules/networking
      ../../system/modules/X11
      ../../system/modules/bluetooth
      ../../system/modules/pipewire
      ../../system/modules/virtualization
      ../../system/modules/syncthing
# --- USER CONFIGURATION ---
      ../../user/modules/steam
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
  services.printing.enable = true;

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
  programs.hyprland.enable = true;
hardware.opengl.enable = true;

#  xdg.portal = {
#    enable = true;
#    extraPortals = [
#      pkgs.xdg-desktop-portal
#      pkgs.xdg-desktop-portal-gtk
#    ];
#  };

system.stateVersion = systemSettings.systemstate;

}

