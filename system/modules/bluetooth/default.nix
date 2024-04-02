{ ... }:

{
  hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  hardware.pulseaudio.extraConfig = ''
    load-module module-switch-on-connect
    '';
}
