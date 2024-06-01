{ config, pkgs, ... }:

{
  services.smokeping = {
    enable = true;
    config = ''
      *** General ***

      owner = Admin
      contact = admin@tts.com
      imgcache = /var/cache/smokeping/images
      imgurl = ../smokeping/images
      datadir = /var/lib/smokeping
      piddir = /var/run
      smokemail = /etc/smokeping/smokemail
      tmail = /etc/smokeping/tmail

      *** Alerts ***

      to = admin@example.com
      from = smokeping@example.com

      *** Probes ***
      
      + FPing
      
      binary = /usr/bin/fping

      *** Targets ***
      
      probe = FPing

      + Localhost
      
      menu = Top
      title = Localhost
      host = localhost
    '';
    alertConfig = ''
      # Sample alert
      +loss
      type = loss
      pattern = >0%,*12*,>0%,*12*,>0%
      comment = loss
    '';
    databaseConfig = ''
      step = 300
      pings = 20

      # consfn mrhb loss% rtt rttmin rttmax
      # each mrhb (measurement/heartbeat) is 300*24*12/60 = 144 readings ~ 2 hours

      AVERAGE   0.5  0.5  288  300  600
      MAX       0.5  0.5  288  300  600
      MIN       0.5  0.5  288  300  600
    '';
    probeConfig = ''
      + FPing
      
      binary = /usr/bin/fping
    '';
    targetConfig = ''
      probe = FPing

      + Localhost
      
      menu = Top
      title = Localhost
      host = localhost
    '';
    mailHost = "localhost";
    ownerEmail = "admin@tts.com";
    user = "smokeping";
  };

  systemd.services.smokeping = {
    description = "Smokeping Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.smokeping}/bin/smokeping --nodaemon";
      User = "smokeping";
      Environment = [
        "MAILHOST=localhost"
        "OWNEREMAIL=admin@tts.com"
      ];
    };

    sockets = [ "smokeping.socket" ];
  };

  systemd.sockets.smokeping = {
    listenStreams = [ "127.0.0.1:8080" ];
    wantedBy = [ "sockets.target" ];
  };

  users.users.smokeping = {
    isSystemUser = true;
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];

  environment.etc."smokeping/config".text = config.services.smokeping.config;
  environment.etc."smokeping/database".text = config.services.smokeping.databaseConfig;
  environment.etc."smokeping/probes".text = config.services.smokeping.probeConfig;
  environment.etc."smokeping/targets".text = config.services.smokeping.targetConfig;
  environment.etc."smokeping/alerts".text = config.services.smokeping.alertConfig;
}

