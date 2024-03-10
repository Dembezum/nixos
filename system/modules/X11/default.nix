{ pkgs, ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

#services.xserver.enable = true;
#services.xserver.displayManager.sddm.enable = true;
#services.xserver.desktopManager.plasma6.enable = true;

#qt = {
#  enable = true;
#  platformTheme = "gnome";
#  style = "adwaita";

  services.xserver.xkb.layout = "dk"; 
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

# Touchpad support
#services.xserver.libinput =  {
#    enable = true;
#    naturalScroll = true;
#    tapping = true;

#  };
# services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
