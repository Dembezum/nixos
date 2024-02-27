{ config, pkgs, ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

# Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

# Touchpad support
# services.xserver.libinput.enable = true;
# services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
