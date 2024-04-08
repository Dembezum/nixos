{ systemSettings, ... }:

{
#  NetworkManager
  networking.networkmanager.enable = true;
  networking.hostName = systemSettings.hostname;

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 8384 22000 61208 ];
    allowedUDPPorts = [ 22000 21027 61208 ];

  };
}
