#{
#  imports = [
##     ./user/modules/gnome
##     ./user/modules/kitty
#      ./user/modules/neovim
#      ./user/modules/normie
#      ./user/modules/shells
#      ./home.nix
##      ./user/modules/tmux
## Add any other user module or configuration
#  ];
#
#}
#
#

{ config, pkgs, ... }:

{
  imports = [
    ../../../user/modules/neovim
    ../../../user/modules/normie
    ../../../user/modules/shells
    ../../../user/modules/tmux
    ./home.nix
    # Add any other user module or configuration as needed
    # Uncomment other imports as necessary
    # ../../../user/modules/gnome/default.nix
    # ../../../user/modules/kitty/default.nix
    # ../../../user/modules/tmux/default.nix
  ];
}

