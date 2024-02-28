{ config, pkgs, ... }:
{
#  NetworkManager
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 ];
#allowedUDPPorts = [ 53 ];

# Port ranges
#      networking.firewall.allowedTCPPortRanges = [
#  { from = 4000; to = 4007; }
#  { from = 8000; to = 8010; }
#];

  };

#  static IP
#    networking.interfaces.eth0.ipv4.addresses = [ {
#    prefixLength = 24;
#    address = "192.168.1.2";
#    networking.defaultGateway = "192.168.1.1";
#    networking.nameservers = [ "1.1.1.1" ];
#}];

# Wireless
#  networking.wireless.networks = {
#  echelon = {                # SSID with no spaces or special characters
#    psk = "abcdefgh";
#  };
#  "echelon's AP" = {         # SSID with spaces and/or special characters
#    psk = "ijklmnop";
#  };
#  echelon = {                # Hidden SSID
#    hidden = true;
#    psk = "qrstuvwx";
#  };
#  free.wifi = {};            # Public wireless network
#};

}
