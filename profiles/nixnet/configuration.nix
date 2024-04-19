{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
      ./dhcpserver.nix
      ../../universal.nix
      ../../system/modules/ssh
      ./hardware-configuration.nix
  ];

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    dockerCompose
  ];

  networking = {
    nameservers = [ "192.168.1.160" ];
    defaultGateway = {
      address = "192.168.1.1";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
        {
          address = "192.168.1.2";
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
    allowedTCPPorts = [ 22 443 80 61208 ];
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

