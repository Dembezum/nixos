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
    nameservers = [ "1.1.1.1" ];
    defaultGateway = {
      address = "10.0.40.2";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
        {
          address = "10.0.40.110";
          prefixLength = 24;
        }
        ];
      };
    };
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

