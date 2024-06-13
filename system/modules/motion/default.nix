{ config, pkgs, ... }:
# -- MOTION CONFIGURATION --

let
motionConfig = ''
 daemon on
 stream_localhost off
 stream_port 8081
 stream_quality 100
 stream_maxrate 30
 stream_localhost off
 stream_auth_method 0
 webcontrol_localhost off
 webcontrol_port 8080
 output_pictures off
'';
in
{
  environment.etc."motion/motion.conf".text = motionConfig;

  systemd.services.motion = {
    description = "Motion - Video Surveillance";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.motion}/bin/motion -c /etc/motion/motion.conf";
      ExecReload = "${pkgs.systemd}/bin/systemctl reload motion";
      Restart = "always";
      User = "root";
      Group = "root";
    };
  };
}

