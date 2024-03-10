{ pkgs, ... }:

{

  programs.neovim.withNodeJs = true;

# Ensure desired packages are available in the user environment.
  home.packages = with pkgs; [
    lua-language-server
      #rustup
      neovim
      nodejs_21
      lua-language-server 
      neovim
      #nixd 
  ];
}

# Example: Adding custom plugins
# programs.neovim.plugins = with pkgs.vimPlugins; [
#   {
#     plugin = example-plugin;
#     config = ''
#       " Plugin-specific configurations here
#     '';
#   },
# ];

