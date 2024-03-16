{ ... }:

{
  imports = [
    ./displaylink.nix
  ];

# Gnome
<<<<<<< HEAD
<<<<<<< HEAD
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

#  services.xserver.enable = true;
#  services.xserver.displayManager.sddm.enable = true;
#  services.xserver.desktopManager.plasma6.enable = true;
=======
#  services.xserver.enable = true;
=======
>>>>>>> 620d2f9 (updates nvidia)
  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;

#  services.xserver.displayManager.sddm.enable = true;
<<<<<<< HEAD
  services.xserver.desktopManager.plasma6.enable = true;
>>>>>>> 2749093ea44b25ce574a423b3663d8940dd15418
=======
  services.desktopManager.plasma6.enable = true;
>>>>>>> 620d2f9 (updates nvidia)

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
# services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

}
