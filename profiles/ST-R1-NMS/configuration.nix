{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
      ./librenms.nix
      ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./hardware-configuration.nix
  ];

  networking = {
    hostname = "ST-R1-NMS";
    nameservers = [ "1.1.1.1" ];
    defaultGateway = {
      address = "10.0.20.2";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
        {
          address = "10.0.20.110";
          prefixLength = 24;
        }
        ];
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 81 22 443 3306 22000 61208 61209 ];
  };

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

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}
