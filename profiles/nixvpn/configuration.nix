{ systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
{
  imports = [
    ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/ssh
      ../../system/modules/glances
  ];

  environment.systemPackages = [ 
    pkgs.tailscale 
  ];

  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set cc=80
        set number
        set relativenumber
        set hlsearch = false
        set incsearch = true
        set swapfile = false
        set cursorline = true
        set virtualedit = "block"
        endif
        '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ ctrlp ];
      };
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  boot.loader.grub.devices = [ "/dev/xvda" ];

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  networking = {
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.113";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "10.0.40.1";
    nameservers = [ "1.1.1.1" ];
  };

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}
