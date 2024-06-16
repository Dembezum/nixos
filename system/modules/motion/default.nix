{ config, pkgs, lib, ... }:
{
  imports = [
    ./motion.nix
  ];

  services.motion = {
    enable = true;
    instances = {
      camera1 = {
        configText = ''
# Motion configuration for camera1
        width 1920
        height 1080
        framerate 24
        videodevice /dev/video0
        target_dir /home/nixping/motion/camera1
        output_pictures off
        ffmpeg_output_movies on
        stream_port 8081
        stream_localhost off
        stream_quality 100
        stream_maxrate 10
        threshold 1500
        noise_level 32
        pre_capture 2
        post_capture 5
          '';
        extraOpts = [ ];
        limitDays = 14;
        limitMebibytes = 4096; # 4 GB
      };
    };
  };
}
