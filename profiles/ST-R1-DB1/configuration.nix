{ systemSettings, userSettings, ... }:

{
  imports = [
      ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./hardware-configuration.nix
      ./database.nix
  ];

  networking = {
    nameservers = [ "1.1.1.1" ];
    defaultGateway = {
      address = "10.0.20.2";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
        {
          address = "10.0.20.30";
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
    allowedTCPPorts = [ 22 80 8080 443 53 ];
    allowedUDPPorts = [ ];
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}

