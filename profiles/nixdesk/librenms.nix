{ config, pkgs, ... }:

{
  services.librenms = {
    enable = true;

    # Paths Configuration
    logDir = "/var/log/librenms";
    dataDir = "/var/lib/librenms";
    hostname = "nixdesk.zum.local";

    extraConfig = ''
    '';
  };
}

