{ pkgs, ... }:

{
  imports = [
#    ./displaylink.nix
  ];

  services.xserver.enable = true;
  services.xserver.xkb.layout = "dk"; 
  #services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
  services.xserver.videoDrivers = [ "modesetting" ];

}
