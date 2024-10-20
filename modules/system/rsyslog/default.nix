{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      # Load necessary modules
      module(load="imudp")  # for UDP syslog reception
      input(type="imudp" port="1514")

      module(load="imtcp")  # for TCP syslog reception
      input(type="imtcp" port="1514")

      # Log all authpriv messages (including sudo) to /var/log/sudo.log
      authpriv.* /var/log/sudo.log

      # Log all incoming messages to the remote syslog server
      *.* @@10.0.40.48:1514
    '';
  };

  # Ensure the sudo log file exists and has correct permissions
  systemd.tmpfiles.rules = [
    "f /var/log/sudo.log 0640 root adm - -"
  ];

  # Open firewall ports for syslog
  networking.firewall.allowedTCPPorts = [ 1514 ];
  networking.firewall.allowedUDPPorts = [ 1514 ];

}
