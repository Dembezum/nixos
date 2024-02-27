{ config, lib, pkgs, ... }:
{
  imports = [
#     ./user/modules/gnome
#     ./user/modules/kitty
      ./user/modules/neovim
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

}


