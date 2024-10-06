{
  # Bluetooth support

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = { Experimental = true; };

      };
    };
  };

  services.blueman.enable = true;

  hardware.pulseaudio.extraConfig = ''
    load-module module-switch-on-connect
  '';
}
