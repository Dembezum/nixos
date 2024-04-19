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

# DHCP Pool configuration
      subnet4 = [
      {
        subnet = "192.168.1.0/24";
        pools = [
        {
          pool = "192.168.1.110 - 192.168.1.254";
        }
        ];
        option-data = [
        { name = "routers"; data = "192.168.1.1"; }
        { name = "domain-name-servers"; data = "192.168.1.160, 1.1.1.1"; }
        ];
      }
      ];
    };
  };
}
