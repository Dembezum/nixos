{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
      ./bind.nix
      ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/glances
      ../../system/modules/ssh
  ];

  environment.systemPackages = [ 
    pkgs.tailscale 
  ];

  boot.loader.grub = {
	  enable = true;
	  device = "/dev/sda";
	  useOSProber = true;
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  networking = {
    firewall.enable = false;
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.200";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "10.0.40.2";
    nameservers = [ "1.1.1.1" ];
  };

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}
