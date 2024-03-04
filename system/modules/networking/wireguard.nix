{ ... }:

{
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; 
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820;
      privateKeyFile = "path to private key file";
      peers = [
        {
          publicKey = "{server public key}";

          allowedIPs = [ "0.0.0.0/0" ]; # Forward all traffic through the VPN
          # for specific subnet routing
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          endpoint = "{server ip}:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
