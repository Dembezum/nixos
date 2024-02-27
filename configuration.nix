{ config, pkgs, ... }:

{
  imports =
    [ 
# Default
      ./hardware-configuration.nix
      ./system/regional
      ./universal.nix
# Networking
      ./system/networking
#  X11
      ./system/displaylink
      ./system/X11
# Audio
      ./system/bluetooth
      ./system/pipewire
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.printing.enable = true;
  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixtop = {
    isNormalUser = true;
    initialPasswd = "passwd";
    description = "nixtop";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "23.11";

}
