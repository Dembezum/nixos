{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
        nvim-treesitter.withAllGrammars
        plenary-nvim
        mini-nvim
    ];
  };

# Ensure desired packages are available in the user environment.
    home.packages = with pkgs; [
      lua-language-server
    #    neovim
        lua-language-server 
    #    neovim
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
