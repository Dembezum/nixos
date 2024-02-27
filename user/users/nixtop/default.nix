{ config, pkgs, libs, ... }:

{
  imports = [
#     ./user/modules/gnome
#     ./user/modules/kitty
      ./user/modules/neovim
      ./user/modules/normie
      ./user/modules/shells
      ./home.nix
#      ./user/modules/tmux
# Add any other user module or configuration
  ];

}


