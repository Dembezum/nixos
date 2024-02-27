{ config, pkgs, ... }:

{
  # Ensure package is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    neovim
  ];

  # Package specific configuration
  programs.neovim = {
    enable = true;
    extraConfig = ''
    
    '' # Config goes there ^
  };
}

