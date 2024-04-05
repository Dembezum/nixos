{ systemSettings, userSettings, pkgs, ... }:

# --- VPN CONFIGURATION ---
{
  imports = [
    ./dhcp.nix
      ../../universal.nix
      ../../user/modules/tmux
      ./hardware-configuration.nix
      ../../system/modules/networking
      ../../system/modules/ssh
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

  boot.loader.grub = {
    enable = true;
    grub.device = [ "/dev/sda" ];
    grub.useOSProber = true;

  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "plugdev" "networkmanager" "wheel" ];
    uid = 1000;
  };

  system.stateVersion = systemSettings.systemstate;
}
