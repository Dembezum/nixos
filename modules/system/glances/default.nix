{ pkgs, ... }:

# Glances web server

{
  systemd.services.glances = {
    description = "Glances in Web Server Mode";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
      Restart = "always";
      User = "root";
    };
    enable = true;
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 61208 61209 ];
    allowedUDPPorts = [ ];
  };
}
