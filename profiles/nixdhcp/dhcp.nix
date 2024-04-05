{ pkgs, ... }:

let
  dhcpdConf = pkgs.writeText "dhcpd.conf" ''
    option domain-name "tts.local";
    option domain-name-servers 1.1.1.1;

    default-lease-time 600;
    max-lease-time 7200;

    subnet 192.168.0.0 netmask 255.255.255.0 {
      range 192.168.0.10 192.168.0.100;
      option routers 192.168.0.1;
    }
  '';
in
{
  networking.firewall.allowedUDPPorts = [ 67 68 ];

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "eth0" ];
    extraConfig = dhcpdConf;
  };
}
