{ config, pkgs, ... }:

{

  # Ensure package is installed by declaring it in the home.packages
  home.packages = with pkgs; [
    lua-language-server 
    rust-analyzer 
    neovim
    ripgrep
    nixd 
    gopls 
    clang-tools
    zls

    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server

}

