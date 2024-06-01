{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
    ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/ssh
      ../../system/modules/glances
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
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.111";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "10.0.40.2";
    nameservers = [ "1.1.1.1" ];
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
