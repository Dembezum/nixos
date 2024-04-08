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
    ];
}
