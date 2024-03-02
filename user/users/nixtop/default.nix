{ config, pkgs, ... }:

{
  imports = [
# Desktop
   ../../../user/modules/hyprland
    ../../../user/modules/normie
#   ../../../user/modules/gnome
#   ../../../user/modules/kde
# ../../../user/modules/gtk

# Productivity
    ../../../user/modules/tmux
    ../../../user/modules/kitty
    ../../../user/modules/neovim
    ../../../user/modules/shells
# Home
    ./home.nix
  ];
}

