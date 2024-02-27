{ config, lib, pkgs, ... }:
{
  imports = [
    ./user/modules/gnome/default.nix
      ./user/modules/kitty/default.nix
      ./user/modules/neovim/default.nix
      ./user/modules/normie/default.nix
      ./user/modules/shells/bash.nix
      ./user/modules/tmux/default.nix
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

