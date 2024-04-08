{ ... }:

{
  services.kea = {
    dhcp4.enable = true; 
    dhcp4.settings = {
      interfaces-config = {
        interfaces = [
          "ens18"
        ];
      };

# Lease databse setup
      lease-database = {
        name = "/var/lib/kea/dhcp4.leases";
        persist = true;
        type = "memfile";
      };

# Global values 
      valid-lifetime = 4000;
      rebind-timer = 2000;
      renew-timer = 1000;

# Subnet configuration
      subnet4 = [
      {
        subnet = "192.168.0.0/24";
        pools = [
        {
          pool = "192.168.0.100 - 192.168.0.240";
        }
        ];
        option-data = [
        { name = "routers"; data = "192.168.0.1"; }
        { name = "domain-name-servers"; data = "1.1.1.1, 1.0.0.1"; }
        ];
      }
      ];
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 8384 8000 22000 ];
    allowedUDPPorts = [ 67 68 8000 22000 21027 ];

  };
}