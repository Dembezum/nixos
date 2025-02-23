{ pkgs, ... }: {
  # Bluetooth support

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      #      package = pkgs.bluez;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
          ConnectionType = "dual";

        };

      };
    };
  };

  services.blueman.enable = true;

  hardware.pulseaudio.extraConfig = ''
    load-module module-switch-on-connect
  '';
}
