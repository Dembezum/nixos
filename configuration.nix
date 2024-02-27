{ config, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ./system/universal.nix
    ./system/displaylink
    ./system/X11
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.printing.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.openssh.enable = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.firewall.enable = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
  console.keyMap = "dk-latin1";

# Configure keymap in X11
  services.xserver = {
    layout = "dk";
    xkbVariant = "";
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };


# Touchpad support
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixtop = {
    isNormalUser = true;
    description = "nixtop";
    extraGroups = [ "networkmanager" "wheel" ];
  };

system.stateVersion = "23.11";

}
