{ ... }:

{
  imports = [
#    ./displaylink.nix
  ];

  services.xserver.enable = true;
  services.xserver.xkb.layout = "dk"; 
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  services.xserver.videoDrivers = [ "modesetting" ];
}
