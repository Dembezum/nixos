{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
      ../../universal.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./hardware-configuration.nix
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


  networking = {
    hostName = "nixgraph";
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
    allowedTCPPorts = [ 22 443 3000 22000 61208 61209 ];
    allowedUDPPorts = [ 22000 21027 61208 ];

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

services.grafana = {
  enable = true;
  settings = {
    server = {
      http_addr = "127.0.0.1";
      http_port = 3000;
      domain = "zum.local";
      root_url = "https://nixgraph.zum.local/grafana/"; # Not needed if it is `https://your.domain/`
      serve_from_sub_path = true;
    };
  };
};

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}
