{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
    ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./mediawiki
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
      address = "10.0.20.103";
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

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };


  system.stateVersion = systemSettings.systemstate;
}
