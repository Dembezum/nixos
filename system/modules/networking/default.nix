{ systemSettings, ... }:

{
  #  NetworkManager
  networking = {
    networkmanager.enable = true;
    hostName = systemSettings.hostname;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 22 443 8384 22000 61208 ];
      allowedUDPPorts = [ 22000 53317 21027 61208 ];
    };
  };

}
