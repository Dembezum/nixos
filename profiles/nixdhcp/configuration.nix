{ systemSettings, userSettings, ... }:

{
  imports = [
    ./dhcpserver.nix
      ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/ssh
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 61208 ];
    allowedUDPPorts = [ 67 68 61208 ];
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  system.stateVersion = systemSettings.systemstate;
}
