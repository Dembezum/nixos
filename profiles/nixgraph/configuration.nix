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
    nameservers = [ "1.1.1.1" ];
    defaultGateway = {
      address = "10.0.20.110";
      interface = "ens18";
    };
    interfaces = {
      ens18 = {
        ipv4.addresses = [
        {
          address = "10.0.20.2";
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

services.nginx.virtualHosts."nixgraph.zum.local" = {
  addSSL = true;
  enableACME = true;
  locations."/grafana/" = {
      proxyPass = "http://${toString config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
  };
};
  system.stateVersion = systemSettings.systemstate;
}
