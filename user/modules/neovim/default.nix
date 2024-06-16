{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    lua-language-server
      nixd
      nodePackages_latest.vscode-langservers-extracted 
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.typescript-language-server 
#      nodePackages_latest.bash-language-server
      nodePackages_latest.dockerfile-language-server-nodejs
      nodePackages_latest.yaml-language-server
    ];
}
