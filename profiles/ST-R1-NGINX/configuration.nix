{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
      ../../universal.nix
      ../../system/modules/ssh
      ./hardware-configuration.nix
      ../../system/modules/glances
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
          address = "192.168.1.3";
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
    allowedTCPPorts = [ 22 80 443 61208 ];
    allowedUDPPorts = [ 61208 ];
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

