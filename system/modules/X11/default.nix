{ ... }:

{
  imports = [
  ];
  services.xserver.enable = true;
  services.xserver.xkb.layout = "dk"; 
  services.xserver.displayManager.gdm.enable = true;
#  services.displayManager.sddm.enable = true;
#  services.displayManager.sddm.wayland.enable = true;
#  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
#  qt = {
#    enable = true;
#    platformTheme = "gnome";
#    style = "adwaita-dark";
#  };

}
