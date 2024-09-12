{
  services.kea = {
    dhcp4.enable = true;
    dhcp4.settings = {
      interfaces-config = { interfaces = [ "ens18" ]; };

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
      subnet4 = [{
        subnet = "10.0.30.0/24";
        pools = [{ pool = "10.0.30.10 - 10.0.30.200"; }];
        option-data = [
          {
            name = "routers";
            data = "10.0.30.2";
          }
          {
            name = "domain-name-servers";
            data = "1.1.1.1, 1.0.0.1";
          }
        ];
      }];
    };
    subnet4 = [{
      subnet = "10.0.40.0/24";
      pools = [{ pool = "10.0.40.10 - 10.0.40.200"; }];
      option-data = [
        {
          name = "routers";
          data = "10.0.40.2";
        }
        {
          name = "domain-name-servers";
          data = "1.1.1.1, 1.0.0.1";
        }
      ];
    }];
  };
}
