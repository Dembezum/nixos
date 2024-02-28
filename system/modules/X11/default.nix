{ config, pkgs, ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

# Kde Plasma
# services.xserver.displayManager.sddm.enable = true;
# services.xserver.desktopManager.plasma5.enable = true;

# Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

# Configure keymap in X11
  services.xserver = {
    layout = "dk";
    xkbVariant = "";
  };


# Touchpad support
#services.xserver.libinput =  {
#    enable = true;
#    naturalScroll = true;
#    tapping = true;

  };
# services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
