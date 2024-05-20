{ ... }:

{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      # Load necessary modules
      module(load="imudp")  # for UDP syslog reception
      input(type="imudp" port="514")
      
      module(load="imtcp")  # for TCP syslog reception
      input(type="imtcp" port="514")
      
      # Define a template for log file locations
      template(name="RemoteLogs" type="string" string="/var/log/remote/%HOSTNAME%/%$YEAR%-%$MONTH%-%$DAY%.log")

      # Log all incoming messages using the defined template
      *.* ?RemoteLogs
    '';
  };

  # Open firewall ports for syslog
  networking.firewall.allowedTCPPorts = [ 514 ];
  networking.firewall.allowedUDPPorts = [ 514 ];

  # Optional: Log rotation setup
  services.logrotate = {
    enable = true;
    config = ''
      /var/log/remote/*/*.log {
        daily
        missingok
        rotate 14
        compress
        delaycompress
        notifempty
        create 0640 root root
        sharedscripts
        postrotate
          /bin/systemctl reload rsyslog.service > /dev/null 2>&1 || true
        endscript
      }
    '';
  };
}

