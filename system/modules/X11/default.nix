{ config, pkgs ..}

{
    # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  # services.xserver.displayManager.sessionCommands = '' ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0 '';

  }
