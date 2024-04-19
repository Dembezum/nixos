{ systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
{
  imports = [
    ../../universal.nix
      ./hardware-configuration.nix
      ../../system/modules/networking
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

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  system.stateVersion = systemSettings.systemstate;
}
