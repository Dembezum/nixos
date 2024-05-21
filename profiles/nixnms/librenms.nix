{ config, pkgs, ...}:

{

  services.librenms = {
    enable = true;
    dataDir = "/var/lib/librenms";
    logDir = "/var/log/librenms";
    hostname = "librenms.zum.local";
    user = "librenms";
    group = "librenms";
  };
};
