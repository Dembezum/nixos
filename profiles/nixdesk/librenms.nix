{ config, pkgs, ... }:

{
  services.librenms = {
    enable = true;
    nginx = {
      enable = true;
      serverName = "nixweb.zum.local";
      listen = [
        {
          addr = "10.0.20.104";
          port = 81;
        }
      ];
    };

    # Database Configuration
    database = {
      host = "localhost";
      port = 3306;
      database = "librenms";
      username = "librenms";
    };

    # Paths Configuration
    logDir = "/var/log/librenms";
    dataDir = "/var/lib/librenms";
    hostname = "nixnms.zum.local";

    # Additional Configurations
    settings = {
      distributed_poller = true;
    };

    extraConfig = ''
    '';
  };
}

