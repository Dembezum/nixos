{ systemSettings, userSettings, pkgs, ... }:

{
  imports = [
    ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/ssh
      ../../system/modules/glances
      ./mediawiki.nix
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
    firewall.enable = false;
    hostName = systemSettings.hostname;
    interfaces = {
      ens18 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "10.0.40.114";
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

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  services.qemuGuest.enable = true;
  system.stateVersion = systemSettings.systemstate;
}
