{ pkgs, ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

#  services.xserver.displayManager.sddm.enable = true;
#  services.desktopManager.plasma6.enable = true;

#  qt = {
#    enable = true;
#    platformTheme = "gnome";
#    style = "adwaita";
#  };

  services.xserver.enable = true;
  services.xserver.xkb.layout = "dk"; 
  services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];

# Touchpad support
#services.xserver.libinput =  {
#    enable = true;
#    naturalScroll = true;
#    tapping = true;

#  };
services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
