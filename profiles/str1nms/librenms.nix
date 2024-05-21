{ config, pkgs, ...}:

{
  services.librenms = {
    enable = true;
    dataDir = "/var/lib/librenms";
    logDir = "/var/log/librenms";
    hostname = "librenms.zum.local";
    user = "librenms";
    group = "librenms";
    database = {
        createLocally = true;
        database = "librenms";
        host = "localhost";
        username = "librenms";
        port = 3306;
        passwordFile = "/run/secret/librenms-db-password";
      };
  };
}
