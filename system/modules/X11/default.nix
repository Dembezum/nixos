{ ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

# Configure keymap in X11
  services.xserver.xkb.layout = "dk"; 

# Touchpad support
#services.xserver.libinput =  {
#    enable = true;
#    naturalScroll = true;
#    tapping = true;

#  };
# services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
