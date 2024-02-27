{ config, pkgs, ... }:

{
  imports = [ 
# Default
      ./hardware-configuration.nix
      ./system/region
      ./universal.nix
# Networking
      ./system/modules/networking
#  X11
      ./system/modules/X11
# Audio
      ./system/modules/bluetooth
      ./system/modules/pipewire
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
    description = "nixtop";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "23.11";

}
