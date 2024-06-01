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
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.112";
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

