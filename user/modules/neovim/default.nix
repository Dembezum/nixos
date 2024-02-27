{ config, lib, pkgs, ... }:

let
# Define custom configurations or packages here, if necessary.
in
{
# Ensure Neovim is enabled and configured according to your preferences.
  programs.neovim = {
    enable = true;
# Add more configuration options here as needed.
  };

# Example: Adding custom plugins
# programs.neovim.plugins = with pkgs.vimPlugins; [
#   {
#     plugin = example-plugin;
#     config = ''
#       " Plugin-specific configurations here
#     '';
#   },
# ];

# Ensure desired packages are available in the user environment.
  home.packages = with pkgs; [
    lua-language-server
      rustup
      neovim
      ripgrep
      lua-language-server 
      rust-analyzer 
      neovim
      ripgrep
      nixd 
      gopls 
      clang-tools
      zls
  ];
}
