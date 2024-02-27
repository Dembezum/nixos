{ config, lib, pkgs, ... }:
{
  imports = [
    ./user/modules/gnome
#      ./user/modules/kitty
#      ./user/modules/neovim
      ./user/modules/normie
      ./user/modules/shells
#      ./user/modules/tmux
# Add any other user module or configuration
  ];

  home.username = "nixtop";
  home.homeDirectory = "/home/nixtop";
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";


  programs.git = {
    enable = true;
    userName = "dembezuma";
    userEmail = "dembezuuma@gmail.com";
  };

    # SSH Configuration
  programs.ssh = {
    enable = true;
    # Assuming you have your private keys in /home/nixtop/.ssh
    # You can specify multiple keys by adding more entries under keys
    keys = [
      {
        name = "id_rsa"; # Name of your private key file
        path = "/home/nixtop/.ssh/id_rsa"; # Full path to your private key
        # If your key is encrypted with a passphrase, set this to true
        # Otherwise, you can remove this line or set it to false
        # isEncrypted = false;
      }
    ];
  };


}

