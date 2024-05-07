{ systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
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

{ systemSettings, ... }:

{

#  NetworkManager
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
# Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 443 8080 53 80 443 61208 ];
    allowedUDPPorts = [ 61208 ];

  };
}

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };


  system.stateVersion = systemSettings.systemstate;
}
