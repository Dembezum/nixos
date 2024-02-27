{ config, lib, pkgs, ... }:

{

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
      neovim
      ripgrep
      nixd 
      gopls 
      clang-tools
      zls
  ];
}
