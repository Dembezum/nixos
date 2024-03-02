{ config, pkgs, ... }:

{
  imports = [
# Desktop
    ../../../user/modules/gnome
    ../../../user/modules/normie
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

