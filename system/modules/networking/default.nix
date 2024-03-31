{ systemSettings, ... }:
{
# Tailscale
  services.tailscale = {
      enable = true;
    };

#  NetworkManager
  networking.networkmanager.enable = true;
  networking.hostName = systemSettings.hostname;

# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];

  };

#  static IP
#    networking.interfaces.eth0.ipv4.addresses = [ {
#    prefixLength = 24;
#    address = "192.168.1.2";
#    networking.defaultGateway = "192.168.1.1";
#    networking.nameservers = [ "1.1.1.1" ];
#}];

}
