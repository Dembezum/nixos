{ systemSettings, userSettings, ... }:

{
  imports = [
    ./dhcpserver.nix
      ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./hardware-configuration.nix
  ];

  networking = {
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.110";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "10.0.40.2";
    nameservers = [ "1.1.1.1" ];
  };


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

